function samples = readIQSamplesFromFile(fd, num_samples)
    try
        samples = fread(fd, [2, num_samples], "float32");
        samples = complex(samples(1, :), samples(2,:));
        samples = samples.';
    catch exception
        disp('Reached file end');
        samples = [];
    end
end
