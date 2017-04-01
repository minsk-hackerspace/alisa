
def process(msg):
  # quick check if the message should be processed
  if not "spynet" in msg:
    return False

  if "spynet#" in msg:
    _, issue = spynet.split('#', 1)
    return "https://github.com/minsk-hackerspace/spynet/issues/" + issue
    
"""
spynet False
spynet# False
spynet#6 https://github.com/minsk-hackerspace/spynet/issues/6
megaspynet#6
spynet#6#6 False
"""
