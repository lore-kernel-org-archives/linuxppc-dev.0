Message-ID: <3D77D72D.1020505@mvista.com>
Date: Thu, 05 Sep 2002 15:14:05 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Fanny Wakizaka <fanny.wakizaka@cyclades.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA cards for MPC8xx?
References: <005d01c254fc$220722e0$5fa1ba40@optiplex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Fanny Wakizaka wrote:

>Hi,
>We are developing a custom hw based on the MPC855 with support to PCMCIA. We
>are using MontaVista linux kernel 2.4.17.
>Could you give me some suggestions of PC Cards that worked with MPC8xx? I'm
>looking for ethernet cards, modem cards and wireless cards.
>Thanks in advance,
>Fanny
>
I have used: cisco 340/350 and lucent wlan cards, 3com 3c589 lan cards,
and modems cards do not work.  The problem with modem cards had
something to do with a dependancy on serial.c (8xx uses
arch/ppc/8xx_io/uart.c).  I don't remember the exact problem now.

>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
