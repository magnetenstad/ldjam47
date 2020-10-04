from os import path
from pydub import AudioSegment

# files                                                                         
srcs = ["in_your_arms", "ping", "writing", "letter_arrives"]

# convert wav to mp3
for src in srcs:                                                        
    sound = AudioSegment.from_mp3(src + ".mp3")
    sound.export(src + ".wav", format="wav")