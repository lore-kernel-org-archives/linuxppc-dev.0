Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCC1ADDF35
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 03:05:45 +1000 (EST)
Date: Tue, 10 Apr 2007 17:11:25 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: IDE driver in polling mode
Message-ID: <20070410171125.3aeed29d@the-village.bc.nu>
In-Reply-To: <461B9D04.2000109@ru.mvista.com>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>     Ah, no interrupts at all...
>     The old IDE core in drivers/ide/ certainly doesn't support polling mode 
> and IRQ-less devices. AFAICS, libata also doesn't support the latter...

libata has much of the framework to do this as it originally did all of
its PIO work much this way. That is probably the most productive place to
start hacking.

Alan
