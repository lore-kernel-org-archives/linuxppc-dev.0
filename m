Message-ID: <366C1BB4.84BF174@zg.tel.hr>
Date: Mon, 07 Dec 1998 19:17:29 +0100
From: Stanko Juzbasic <stanko.juzbasic@zg.tel.hr>
Reply-To: stanko.juzbasic@zg.tel.hr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: AUDIO files don't seem to play...
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



To whoever it may concern...

I have recently installed Linux_PPC R4 (kernel 2.1.24)  on a PowerMac
7200 with PowerPC 601 chip.
I am interested in audio.
I tried to play a few straigrtforward 44.1 k audio files (.wav; .aiff;
.au; .snd; raw), plain PCM,
no compression -it does not work: unpleasant gaps dominate the
reproduction. I used the comand
play (from SOX, which is the only audio utility that seems to come with
the system). It seems to do something
with double buffering, or timing problems, I checked every piece of
documentation that I came across, no mention.
I recompiled the kernel, recompiled SOX, it's all the same.
On the other hand audio CDs are being played flawlessly.
If anybody has experienced such a problem, I would be glad to be told
about the remedy, else, I am curious to report it.

Thanks in advance!

stanko



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
