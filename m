Message-ID: <3DD86788.9040701@gmx.de>
Date: Mon, 18 Nov 2002 12:07:36 +0800
From: Michael Habermann <mhabermann@gmx.de>
MIME-Version: 1.0
To: Leonardo Pereira Santos <lsantos@pd3.com.br>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Card Services in a FADS850SAR board
References: <200211121926.09433.lsantos@pd3.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Leonardo Pereira Santos wrote:

>	I'm configuring my kernel to support:
>	- hot plugable devies,
>	- CardBus,
>	- 8xx support
>
Have you tried a non-kernel version of pcmcia-cs?
For the 850, you need to take care that PCMCIA_SLOT_B is defined,
instead of PCMCIA_SLOT_A.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
