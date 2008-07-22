Return-Path: <super.firetwister@googlemail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id CB6BBDE1C1
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 02:13:16 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so878591fga.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 09:13:13 -0700 (PDT)
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: UIO not working on ppc405 onchip registers
Date: Tue, 22 Jul 2008 18:20:21 +0200
References: <200807212152.16080.super.firetwister@gmail.com>
	<20080722061730.GB12576@digi.com>
	<200807220947.43074.super.firetwister@gmail.com>
In-Reply-To: <200807220947.43074.super.firetwister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807221820.22333.super.firetwister@gmail.com>
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

On Tuesday 22 July 2008, super.firetwister@gmail.com wrote:
> Hello Uwe,
>
> On Tuesday 22 July 2008, Uwe Kleine-K=F6nig wrote:
> > I don't know powerpc in general nor ppc405ep in detail but IIRC arm has
> > problems if some memory is mapped twice.  Might this be the problem
> > here?
>
> Maybee, the emac0 (0xef600800) and emac1 (0xef600900) get mapped as well,
> because AFAIK I have to map a whole pagesize (0x1000).

Same problem without emac module loaded.

Did anybody tried to reproduce the problem?

Regards

Markus
