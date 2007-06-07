Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8417CDDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jun 2007 06:15:52 +1000 (EST)
Message-ID: <466867E3.9030505@ru.mvista.com>
Date: Fri, 08 Jun 2007 00:17:39 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: how are the interrupts mapped on the taiga board?
References: <556445368AFA1C438794ABDA8901891C066B5AC5@usa0300ms03.na.xerox.net>
In-Reply-To: <556445368AFA1C438794ABDA8901891C066B5AC5@usa0300ms03.na.xerox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Lund, Nathan" <Nathan.Lund@xerox.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Leisner, Martin wrote:
> I'm looking at mpc7448hpc2.dts -- and the tsi108 specs...

> I see how TTYS0 is IRQ12 and the ethernet is IRQ16...that agrees with
> the file...
> and the tundra TSi108 spec.

> But in after we boot in /proc/interrupts:
> 
>  16:       1796  Tsi108_PIC Edge      serial
>  18:      24148  Tsi108_PIC Level     eth0

> I don't see in the .dts a mapping from 12->16 and 16->18.
> Nore have I found anything in the source...

> I using 2.6.21.1.

> How is this done?

    It's done by arch/powerpc kernel itself which remaps any IRQs < 16.

WBR, Sergei
