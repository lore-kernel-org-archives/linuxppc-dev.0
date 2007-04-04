Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 156F5DDF92
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:11:04 +1000 (EST)
Message-ID: <4613CDB6.30306@zytor.com>
Date: Wed, 04 Apr 2007 09:09:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403230908.GA13471@cynthia.pants.nu>
	<20070404085159.GB13134@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0704041146290.30582@anakin>
In-Reply-To: <Pine.LNX.4.64.0704041146290.30582@anakin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> 
> Oh, and I always thought PTYs were moved to free up more minors for our
> zillions of serial ports...
> 

No, PTYs were moved because 64 ptys were woefully inadequate.  256 ptys 
were enough of a shortage for many users.

The use of 16-bit Minix device numbers was a major headache in Linux for 
many, many years.  We didn't get past that one until the 2.6 kernel series.

	-hpa
