<?php
namespace Commands;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Formatter\OutputFormatterStyle;
use Database\select;
use Output\json as json;
use Output\csv as csv;

class SelectCommand extends Command
{
    protected function configure()
    {
        $this->setName("Query:Select")
            ->setDescription("Gets data from the database, and outputs to file.")
            ->addArgument('file', InputArgument::REQUIRED, 'What select query do you want to run?')
            ->addArgument('output', InputArgument::REQUIRED, 'What is the file you want to output to?')
            ->addArgument('values', InputArgument::IS_ARRAY | InputArgument::OPTIONAL, 'What bound values are required for this query to run (space separated)?');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $file = $input->getArgument('file');
        $outputfile = $input->getArgument('output');
        $values = $input->getArgument('values');
        
        if (is_file($file)) {
            $statement = file_get_contents($file);
        }
        $select = new select();
        $data = $select->doSelect(
            $statement ?? $file,
            $values ?? array()
        );
        if (strpos($outputfile, 'json')) {
            $out = new json();
        } else {
            $out = new csv();
        }
        if ($out->output($data, $outputfile) === true) {
            $output->writeln('Successfully wrote ' . count($data) . ' records to file: ' . $outputfile);
        } else {
            $output->writeln('Failed writing to: ' . $outputfile);
        }
    }
}