To: greggiraud@netcourrier.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot 8260 LXT971A 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 Jun 2003 10:12:10 EST."
             <mnet1.1056960730.12133.greggiraud@netcourrier.com>
Date: Mon, 30 Jun 2003 10:58:53 +0200
Message-Id: <20030630085859.0A408C592A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Grego,

in message <mnet1.1056960730.12133.greggiraud@netcourrier.com> you wrote:
>
> I installed a ppcboot and a linux 2.4 on a MPC8260ADS card.

There are some things you should change:

First, PPCBoot is a dead project; development has  been  discontinued
more  than half a year ago. For new development the successor project
"U-Boot" should be used instead.

Second, U-Boot (and PPCBoot) related questions are  off  topic  on  a
LInux  mailing  list.  Please post such questions to the u-boot-users
mailing list instead.

> Now, I am working on a custom card such as an MPC8260ADS card. The difference between those two cards is the ethernet: my custom card has two ethernet port, and uses two LXT971A.
>
> So, I compile a ppcboot for 8260ads. PPCBOOT can't download a kernel with tftp. Is someone has a source code to support the LXT971?

Third, if you have a custom card, you should adapt ("port") U-Boot to
your hardware. Using a configuration that was designed for  different
hardware will always cause some sort of problems.

Finally, both PPCBoot and U-Boot have been supporting the LXT971  for
a long time.

> I compile a new kernel, which support LXT971A. PPCBOOT can run it from memory. But the kernel doesn't have network.

Well, this is a  different  issue,  then.  The  Linux  driver  should
perform  all  required  initialization itself, so no interaction with
U-Boot should happen.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Another megabytes the dust.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
