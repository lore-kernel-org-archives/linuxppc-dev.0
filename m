From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Date: Tue, 25 Jul 2000 22:51:40 -0500
Message-ID: <yam8241.2004.146963968@mail.lf-online.de>
In-Reply-To: <200007251952.UAA21889@hyperion.valhalla.net>
Subject: Re: sound again [was: Re: xf4 bug report]
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 25-Jul-00 schrieb Iain Sandoe:

Hi!

>The dmasound_awacs entry only arrives with the back-port.  As Franz said,
>the error you were getting before was probably due to the conf.modules entry
>- when Ben had built the dmasound in.

Ah.

>1. what does dmesg now show?

DMA sound driver core [Ed 3]

4 Buffers of 32 K for Output
Same for Input

AWACS rev 100

registers:

1400 782d 7810 0001 00a1 0021 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 4000 0000 26bb 0010 0000 0002
0001 0000 0000 0000 0000 0000 0000 0000

>2. have you tried headphones/versus built-in speaker?  (others have reported
>a problem here - which is why the finger of blame is currently pointing at
>the mixer abstraction)...

Up to now only built-in speakers. Will try with headphones :)

>3. what does cat /dev/sndstat say?

PowerMac (AWACS rev 100) DMA sound driver:
  sound.format = 0x20 (signed 16 bit big)
  sound.speed = 44100Hz (phys. 44100Hz)
  sound.stereo = 0x1 (stereo)
  write_sq.block_size = 32768 write_sq.max_count = 4 write_sq.max_active = 4
  write_sq.count = 0 write_sq.rear_size = 4096
  write_sq.active = 0 write_sq.syncing = 0
  read_sq.block_size = 0 read_sq.max_count = 0 read_sq.max_active = 0
  read_sq.count = 0 read_sq.rear_size = 0
  read_sq.active = 0 read_sq.syncing = 0

>4. what are you using to try and get sound out (e.g. some of the kde
>implementations had broken sound anyway) - I never got *any* beeps &
>whistles until I upgraded.

I tried in the Gnome Sound Settings. And I tried Sin naturally :) (Sound
works on Linux-x86, and does not contain any x86-specific code, so normally
it should work on LinuxPPC straight away - if sound is correctly configured,
that is :) )

>I can send or post a prog. that sets the snd output to 16bit LE - so that
>you can just cat <some_file.wav> >/dev/dsp  if that's any use.

>xmms usually works for me (although I've been using the cvs version)...

Well, I have some sound programs here... at least the Sin-stuff should work...
quite straight WAV-replaying...

Steffen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
