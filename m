Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 3708167A76
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 22:49:29 +1100 (EST)
Message-ID: <421F1321.9050508@ru.mvista.com>
Date: Fri, 25 Feb 2005 14:59:29 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: "Finn S. Nielsen" <fn@iotech.dk>
References: <001b01c51b2d$46378890$0c2ca8c0@FNIBM>
In-Reply-To: <001b01c51b2d$46378890$0c2ca8c0@FNIBM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Stuck in booting 2.6.10-ac11 on Memec Design FF1152...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Finn S. Nielsen wrote:
> Hi Jakob,
> 
> I noticed on the embedded powerpc mailing list, that you are working w. linux on the Memec V2P20 FF1152 board.
> I have one too and I'm given the task to get a linux up and running on it...
> 
> What kernel version are you using and where did you get the source ?.
> It seems to me that in the official source tree, there is only support
> for the Xilinx ML300 board - or am I missing something?

If you are speaking about 2.6 then you aren't missing anything.

> Montavista and  MIND systems say they have a port for the memec board, but if an open

MontaVista's code for memec is in linuxppc-2.4 tree.
http://ppc.bkbits.net:8080/linuxppc-2.4/cset@1.1282

We've used 2VP7-FG456 board with the P160 COMM module.


Best rewgards,
Andrei

> source port exists, I'd prefer that.
> 
> Best regards,
> 
> Finn S. Nielsen
> IO Technologies a/s
> Carl Jacobsens Vej 16, opg. 6, 3 sal
> 2500 Valby
> Denmark
> Tlp (direct): +45 36188109
> Fax:. +45 36188101
> Check out our new website: http://www.iotech.dk
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
