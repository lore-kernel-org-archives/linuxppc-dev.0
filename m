Message-Id: <200011060939.eA69dBS30762@denx.local.net>
To: ASchreckenberg@dspace.de
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Debugger Problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Nov 2000 09:47:59 +0100."
             <3A06703F.6D5DBB23@dspace.de>
Date: Mon, 06 Nov 2000 10:39:11 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A06703F.6D5DBB23@dspace.de> you wrote:
>
> I want to port the Monta Vista Linux Kernel on our
> customspecific board. I want to use the EST Debugger

Which firmware are you running on your board? Do you know  about  the
PPCBoot project (http://ppcboot.sourceforge.net)?

> from Windriver, but there are some problems with using
> the MMU, specially while debugging the startup code.

Did you check the Embedded PowerPC HOWTO at
http://members.nbci.com/greyhams/linux/PowerPC-Embedded-HOWTO.html ?

> Is there anybody with experience
> in using the EST Debugger with Linuxcode ?

Can you explain what "some problems" means?

One typical problem in bad intialization of the Debug Even  Register;
make sure DER is set to 0x2002000F or similar before starting Linux.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The use of Microsoft crippleware systems is a sin that  carries  with
it its own punishment.
         -- Tom Christiansen in <6bo3fr$pj8$5@csnews.cs.colorado.edu>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
