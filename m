Return-Path: <super.firetwister@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 0B929DDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 17:41:41 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so311827ugf.0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 00:41:39 -0700 (PDT)
To: Ben Nizette <bn@niasdigital.com>
Subject: Re: UIO not working on ppc405 onchip registers
Date: Tue, 22 Jul 2008 09:48:49 +0200
References: <200807212152.16080.super.firetwister@gmail.com>
	<20080722061730.GB12576@digi.com>
	<1216708967.4004.238.camel@moss.renham>
In-Reply-To: <1216708967.4004.238.camel@moss.renham>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807220948.51053.super.firetwister@gmail.com>
From: super.firetwister@googlemail.com
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 22 July 2008, Ben Nizette wrote:

> As an aside, you sure you want to do this anyway?  

No ;)


> I'd suggest that you 
> just do a gpio chip driver for this, tie it in to gpiolib and use the
> gpiolib user interface (which IIRC has only made it as far as -mm but is
> on the way up).  This gives kernel internals nice access to the pins as
> well through the standard gpio framework.

This was just an example to make it others easier to reproduce my problem. My 
goal is to have a soft spi driver in userspace, which would probably be 
slower if it uses gpiolib. This driver is integrated in the application I 
want to port to Linux. 

Thanks

Markus
