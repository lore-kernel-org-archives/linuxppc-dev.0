Message-ID: <39A5488B.872EE342@relog.ch>
Date: Thu, 24 Aug 2000 18:08:43 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Henry Worth <haworth@ncal.verio.com>
CC: iain@sandoe.co.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
References: <39A54154.E02B3E0C@ncal.verio.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth wrote:

> More recent verisons of esound (looks like those with ALSA changes)
> have had some sort of buffering problem were they would skip blocks
> during playback (with both esdplay and XMMS esd output plugin). The
> blocks that played were at the correct speed, but the
> track/sample would playback as quick as it could be read off
> storage. The backport corrects,  or perhaps covers-up, the problem. I
> need to investigate the root cause some more.

This sounds familiar.

I've been playing with the Quake sound playback In order to enable sound
without mmap support, Steffen Haeuser advised using a dedicated thread which
writes sound data to /dev/dsp.

It basically works, but the sound is somewhat distorted, and I think the
problem might be similar to esd's .


Where is your backport (or rather patches against 2.4.0-testx) available?

Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
