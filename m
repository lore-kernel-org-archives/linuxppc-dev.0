Subject: Re: Problems w/  CONFIG_BLK_DEV_MPC8xx_IDE
From: Hubert Figuiere <hub-linux-arm@trantor.staff.proxad.net>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F65A2FD.3010904@imc-berlin.de>
References: <3F656CFC.1050706@imc-berlin.de>
	 <3F65A2FD.3010904@imc-berlin.de>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1063627208.14615.21.camel@trantor.staff.proxad.net>
Mime-Version: 1.0
Date: Mon, 15 Sep 2003 14:00:08 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2003-09-15 at 13:31, Steven Scholz wrote:

> The BK linuxppc_2_4_devel tree has another problem as well:
>
> drivers/ide/idedriver.o: In function `probe_hwif':
> drivers/ide/idedriver.o(.text+0x11a30): undefined reference to `wait_hwif_ready'
> drivers/ide/idedriver.o(.text+0x11a30): relocation truncated to fit: R_PPC_REL24
> wait_hwif_ready
>
> ide-probe.c contains a call for wait_hwif_ready(), which is not defined.
> This function exisists in the vanilla source though!
>
> I supposed something went wrong while merging/syncing the IDE changes from the
> official tree...

Change 'wait_hwif_ready' by 'ide_wait_hwif_ready' in both ide-probe.c
and ide.c

Trivial, no ?

Hub
--
Hubert Figuière - Freebox SA. - +33 1 73 50 2 563
AIM/Yahoo!: hfiguiere, ICQ: 307453487

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
