Message-ID: <402CFC2C.1090809@imc-berlin.de>
Date: Fri, 13 Feb 2004 17:32:44 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: DavidHo@nanometrics.ca
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EXT_DIRECT IDE Mode
References: <OFFDBDCE26.B71E8E02-ON85256E39.00595A10-85256E39.005A13FA@nanometrics.ca>
In-Reply-To: <OFFDBDCE26.B71E8E02-ON85256E39.00595A10-85256E39.005A13FA@nanometrics.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Steve,
>
> We have decided to move to a newer kernel (2.4.20 or greater).
> As a simple check, would you please give me a list of files with the
> CONFIG_IDE_EXT_DIRECT #ifdef so I can get a bit of assurance that I have
> the support in the kernel before making the move.

#~> grep -r -l CONFIG_IDE_EXT_DIRECT linux-2.4.21/*

linux-2.4.21/drivers/ide/ppc/mpc8xx.c
linux-2.4.21/drivers/ide/Config.in

Good luck,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
