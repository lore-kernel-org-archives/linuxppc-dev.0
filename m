To: "yang" <wchyang_hn@sina.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem of linux's kernel booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Feb 2004 09:31:42 +0800."
             <004101c3eb87$d2cdf090$5e1312ac@yang>
Date: Thu, 05 Feb 2004 09:25:52 +0100
Message-Id: <20040205082557.2C373C10A3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <004101c3eb87$d2cdf090$5e1312ac@yang> you wrote:
>
>     I encounter a problem when booting linux 2.2.4 kernel on FADS860T
> board by ppcboot-2.0.

You are obviously combining several  configurations  that  don't  fit
with   each   other.   And   there   may   be   other   problems   or
misunderstandings:

> After mounting NFS filesystem on my host, the follow message was
> printed in console:

Not the host, but the target will mount the root file system over NFS.

>         eth0: CPM ENET Version 0.2 on SCC1, 44:00:00:00:00:00
>         CFI: Found no TQM8xxL Bank 0 device at location zero
>         CFI: Found no TQM8xxL Bank 1 device at location zero
>         CFI: Found no TQM8xxL Bank 2 device at location zero
>         CFI: Found no TQM8xxL Bank 3 device at location zero
>         TQM8xxL: No support flash chips found!

You mentioned that this was a  FADS860T  board  -  then  why  do  you
configure it for TQM8xxL flash support?

Unless you know exactly what you are doing (which seems not to be the
case) you should rather stick with the default configuration to get a
running system.

> Would you like to tell me how to make NFS filesystem on my host,
> especialy how to config the init options of kenel? Thank you very
> much!

See http://www.denx.de/twiki/bin/view/DULG/Manual

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Blast medicine anyway!  We've learned to tie into every organ in the
human body but one.  The brain!  The brain is what life is all about.
	-- McCoy, "The Menagerie", stardate 3012.4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
