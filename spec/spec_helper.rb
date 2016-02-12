FIXTURE_DIR = File.join(File.dirname(__FILE__), 'fixtures')

def load_fixture(path)
  fixture_file = File.join(FIXTURE_DIR, path)
  File.read(fixture_file)
end