Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FACADDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 06:02:44 +1100 (EST)
Date: Mon, 25 Feb 2008 13:02:35 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: What happened to cpm2_hostalloc
Message-ID: <20080225190235.GB9687@ld0162-tx32.am.freescale.net>
References: <F795765B112E7344AF36AA911279641502D1AAEC@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F795765B112E7344AF36AA911279641502D1AAEC@xmb-sjc-212.amer.cisco.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 25, 2008 at 10:47:04AM -0800, Bizhan Gholikhamseh (bgholikh) wrote:
> In Linux 2.6.11 version, there was a function named "cpm2_hostalloc"  to
> allocate memory at
> specific boundary. I am not able to locate that in the latest Linux
> version, 2.6.24-rc4. Is there any
> similiar function to this that I can use? 
> The SPI module on the CPM2 module required the memory descriptor on the
> ram to be at specific
> boundray (8 bytes).

It's probably best to use DPRAM for the descriptors if possible.  However,
if you want/need to use RAM, just allocate 8 bytes more than you need and
manually align it.

-Scott
