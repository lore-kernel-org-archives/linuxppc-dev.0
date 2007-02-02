Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D989ADDE22
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 17:28:20 +1100 (EST)
In-Reply-To: <200702011408330875.0BD61D69@smtp.dslextreme.com>
References: <200702011408330875.0BD61D69@smtp.dslextreme.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8F04B814-2F03-42B1-BFF3-B44551D6104E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PPC 85xx serial port error
Date: Fri, 2 Feb 2007 00:27:21 -0600
To: Dan Wilson <dwilson@dslextreme.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 1, 2007, at 4:08 PM, Dan Wilson wrote:

> We are using an 8541 processor with ELDK 4.0 and 2.6.15 kernel.
>
> Frequently, if we dump large amounts of output to the console port  
> (for example, if we use 'tar' with the verbose option), we see an  
> error message that starts and scrolls until we reboot the unit:
>     serial8250: too much work for irq90
>
> We see this at 9600 baud and also at 115200 baud, although it seems  
> to happen less often at 115k.
>
> This message comes from serial8250_interrupt, which appears to  
> trigger it if the interrupt handler has looped 256 times through  
> the list?
>
> How is this possible?  If the interrupt routine is running, does  
> that not prevent user threads from running and adding more data to  
> the list?  Or am I not understanding this code correctly?
>
> Any light that anyone can shed on the expected behavior of this  
> driver and any ideas on how to work around this are greatly  
> appreciated!

This question may be better addressed by the linux-kernel mailing  
list since its more about how the serial driver works than anything  
PPC specific.

- k
