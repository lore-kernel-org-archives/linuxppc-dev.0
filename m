Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 545AEDDECF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:35:24 +1000 (EST)
Date: Wed, 4 Apr 2007 02:38:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404023822.53aabc1a@the-village.bc.nu>
In-Reply-To: <20070403230908.GA13471@cynthia.pants.nu>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403230908.GA13471@cynthia.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> my opinion. I do understand that 8250 compatible chips are very common
> and are the most likely serial chips to be used with Linux. However, I
> will point out that the define is TTY_MAJOR, not 8250_MAJOR. It seems
> to me that whoever named it was thinking in more generic terms.

The define goes back the very first days of Linux. I doubt whoever named
it (Linus I imagine) had even considered that anyone else might be
running his terminal emulator at that point.
