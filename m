Message-Id: <200007191513.RAA01451@denx.local.net>
To: Steve Rossi <srossi@ccrl.mot.com>
cc: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Do I shoot myself in the foot first or HEAD.S? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jul 2000 09:09:27 CDT."
             <3975B697.63313411@ccrl.mot.com>
Date: Wed, 19 Jul 2000 17:13:09 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3975B697.63313411@ccrl.mot.com> Steve Rossi wrote:
>
> I wrote a little app that slaps an EST .bin file header on a linux image
> (zvmlinux or zvmlinux.inird). I can send that to you if you want it. Then I use
> Download to Target from VisionClick and that sticks the whole image in RAM. You
> do need to disable VisionICE's interception of software breakpoint emulation
> interrupts - do 'cf sbe special'. That should be it.

BTW - included with the upcoming first public version of PPCBOOT is a
small tool (img2srec) which creates a srecord  file  from  zImage  or
zImage.initrd  files,  omitting unneeded stuff which is included when
just stripping the ELF header and then converting to S-records.  This
saves just another few bytes on the target :-)

Thanks to Ruedi Dummermuth of Abatron who provided this tool.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There's no future in time travel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
