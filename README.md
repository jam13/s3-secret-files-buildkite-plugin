# AWS S3 Secret Files Buildkite Plugin

An extension to (and based on) the AWS S3 Secrets Buildkite Plugin. When used alongside, it allows
secret files to be placed in the pipeline specific folders of the S3 secrets bucket and downloaded
to specific locations within the source.

## Usage

```yaml
steps:
- label: "Build"
  command:
  - build.sh
  plugins:
    - jam13/s3-secret-files#1.0.0:
        files:
        - src: secret-file
          dest: src/secret
        - src: another-secret
          dest: lib/another
        - src: secret-dir
          dest: destination-dir
          args: --recursive
```

## Uploading Files

```bash
aws s3 cp --acl private --sse aws:kms secret-file "s3://buildkite-managedsecretsbucket-1abcdefghijk2/secret-file"
```

## License

MIT (see [LICENSE](LICENSE))
