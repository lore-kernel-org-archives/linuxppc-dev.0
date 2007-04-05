Return-Path: <anemo@mba.ocn.ne.jp>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.175.29])
	by ozlabs.org (Postfix) with ESMTP id 3DE10DDEDF
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:10:19 +1000 (EST)
Date: Thu, 05 Apr 2007 23:31:01 +0900 (JST)
Message-Id: <20070405.233101.106261123.anemo@mba.ocn.ne.jp>
To: dwmw2@infradead.org
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1175696383.2774.24.camel@shinybook.infradead.org>
References: <1175666635.2932.17.camel@shinybook.infradead.org>
	<17939.17962.248566.886449@cargo.ozlabs.ibm.com>
	<1175696383.2774.24.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	device@lanana.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 04 Apr 2007 10:19:43 -0400, David Woodhouse <dwmw2@infradead.org> wrote:
> +#ifdef CONFIG_SERIAL_PMACZILOG_TTYS
> +#define PMACZILOG_MAJOR		TTY_MAJOR
> +#define PMACZILOG_MINOR		64
> +#define PMACZILOG_NAME		"ttyS"
> +#else
> +#define PMACZILOG_MAJOR		204
> +#define PMACZILOG_MINOR		192
> +#define PMACZILOG_NAME		"ttyPZ"
> +#endif

Is major 204 minor 192 already allocated?

Few weeks ago, I sent a patch to allocate 192...199 for other serial
driver (Subject: [PATCH 2.6.21-rc3] serial: Allocate minor device
numbers for serial_txx9 driver):

http://lkml.org/lkml/2007/3/13/246

And it is already in -mm tree since 2.6.21-rc4-mm1.  I just CC-ed the
patch to device@lanana.org, but I really do not know how "master"
devices.txt updated finally.  If I should take some further action to
lanana.org or someone, please let me know.  Thank you.

---
Atsushi Nemoto
