From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14222.9603.505701.976724@gargle.gargle.HOWL>
Date: Thu, 15 Jul 1999 14:16:35 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Broken sound?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I have a Powercenter 120 with 200Mhz 604e card running vanilla 2.2.10.  Sound
seems to be broken.  I do 'cat junk.au > /dev/audio' and get very interesting
sounding static.  Is there a patch in vger I should be using that hasn't made
it into Linus' tree yet or is this an unfixed problem?  Or is my setup screwed
up?  I've got an end of May installation of R5.

Also, if I send a sound to /dev/audio, it plays through both internal and
external speakers.  If I try to send the sound to /dev/audio1, bash claims it
doesn't exist even though it shows up on 'ls'.

If I try to use 'play', I get an error from sox "sox: Invalid audio buffer
size 0".

Any help is appreciated.

Thanks,

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
