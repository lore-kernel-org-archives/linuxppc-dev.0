To: Sylvain Munaut <tnt@246tnt.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux on MPC5200 - LITE5200EVAL 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Feb 2004 22:19:21 +0100."
             <40294AD9.1070407@246tNt.com>
Date: Tue, 10 Feb 2004 23:00:02 +0100
Message-Id: <20040210220007.54753C1215@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40294AD9.1070407@246tNt.com> you wrote:
>
> I've just received the motorola eval board ( one, with 64M SDR and 16Mb
> flash). And I'm a little lost.
> I've tool u-boot sources from CVS compiled them ( compiled fine exect
> for the samples apps ), then took the appropriate kernel sources, build
> it ( make uImage ). And .... then ?

Either use the default configuration of U-Boot and replace  dBUG,  or
use  the  "LOWBOOT"  configuration and install U-Boot at the start of
the flash area.

Then use U-Boot to load and boot Linux.

> I haven't found any "manual" or so.

There is the DULG - there is no  LITE5200  specific  version  of  the
document (yet), but it should get you started.
See http://www.denx.de/twiki/bin/view/DULG/Manual

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you hear an onion ring, answer it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
