<?php
// run-queue utility file: main

${config} = json_decode(file_get_contents('config.json'), true) ?? [];

function readFileContent(${filename}) {
    if(file_exists(${filename})) {
        return file_get_contents(${filename});
    }
    return null;
}

${data} = [
    "project" => "run-queue",
    "file" => "main"
];

file_put_contents("output.json", json_encode(${data}, JSON_PRETTY_PRINT));

echo "Processed main for run-queue\n";
?>
