Message-ID: <3F65B091.1020802@imc-berlin.de>
Date: Mon, 15 Sep 2003 14:29:05 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems w/  CONFIG_BLK_DEV_MPC8xx_IDE
References: <3F656CFC.1050706@imc-berlin.de>	 <3F65A2FD.3010904@imc-berlin.de> <1063627208.14615.21.camel@trantor.staff.proxad.net>
In-Reply-To: <1063627208.14615.21.camel@trantor.staff.proxad.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hubert Figuiere wrote:
> On Mon, 2003-09-15 at 13:31, Steven Scholz wrote:
>
>
>>The BK linuxppc_2_4_devel tree has another problem as well:
>>
>>drivers/ide/idedriver.o: In function `probe_hwif':
>>drivers/ide/idedriver.o(.text+0x11a30): undefined reference to `wait_hwif_ready'
>>drivers/ide/idedriver.o(.text+0x11a30): relocation truncated to fit: R_PPC_REL24
>>wait_hwif_ready
>>
>>ide-probe.c contains a call for wait_hwif_ready(), which is not defined.
>>This function exisists in the vanilla source though!
>>
>>I supposed something went wrong while merging/syncing the IDE changes from the
>>official tree...
>
>
> Change 'wait_hwif_ready' by 'ide_wait_hwif_ready' in both ide-probe.c
> and ide.c
Ok. This obviously fixes it.
I just noticed that I might have used the wrong source tree.

So which is the BK tree to use:

linuxppc_2_4_devel or linuxppc-2.4 ???

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
