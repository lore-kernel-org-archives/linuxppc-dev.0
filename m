To: "aa aaa" <linux_powerpc@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: jffs2 problem help! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Apr 2004 09:26:44 +0800."
             <BAY13-F46HY44cnNRxG0000368d@hotmail.com>
Date: Thu, 22 Apr 2004 08:25:25 +0200
Message-Id: <20040422062530.4B8EEC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BAY13-F46HY44cnNRxG0000368d@hotmail.com> you wrote:
>
> During creating jffs2 ,I modified the file /drive/mtd/maps/rpxlite.c just
> like the file tqm8xxl.c,I refered the manual DULG.after loading and running

I understand that your board is neither a rpxlite nor a TQM8xxL -  so
which board are you using then?

> init_rpxlite_mtd: chip probing count 0
> request_module[cfi_cmdset_0002]: Root fs not mounted
> Support for command set 0002 not present
...
> RPXLITE: No support flash chips found!

Seems you misconfigured  your  MTD  sub-system,  like  selection  CFI
support  when  you  board  in  fact does not use CFI conformant flash
chips. Or your board does not find the correct start address  of  the
flash  memory  -  which  in  case  of  the TQM8xxL gets passed in the
bd_info structure by U-Boot.

> Where is wrong? and when I use the commmand xd ,show no command,why?

Please explain where "xd" comes into play?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
