Message-ID: <3B82602B.1010406@hadess.net>
Date: Tue, 21 Aug 2001 14:20:43 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mixer support on the iBook2
References: <20010821084054.C20089@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Blanton wrote:
> Hi all,
> I have gotten the sound on my iBook2 working (via the files on
> http:/www.hadess.net/files/ppc/ibook2/), and I have some questions...

Please use the dmasound.tar.gz , it's a better driver (anton2 on
#mklinux fixed that 8 days ago), and I'm supposed to clean it up for
integration in BenH's tree (if he and Iain think that it's clean
enough). Or maybe Olaf will just be sick of waiting and do it himself ;)

Given that my iBook is going to the repair shop (the cable to the screen
got hurt and my display goes purple), one might want to take this task.

the dmasound.tar.gz contains a replacement for drivers/sound/dmasound
you still need the i2c-keywest driver from pfh's driver, but not the
dmasound_core hacks anymore.
All the i2c calls should be #ifdef'ed for machines without i2c buses to
still work. And a nice configuration option is needed as well.

> I know there has been some discussion on this list that the OSS mixer
> semantics are insufficient for the PPC sound architecture in modern
> Macs.  I don't know if this is related or not...
>
> In any mixer program I can find, the volume steps on the iBook2 are
> simply too large.  The sound card goes from muted to too loud to use
> through earphones in one step of the slider.  Is this a limitation of
> the hardware, the driver architecture, or what?  Or is it too early to
> be asking?  ;-)

The driver...

Cheers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
