Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B428DDF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 20:13:14 +1100 (EST)
Date: Thu, 13 Mar 2008 10:13:08 +0100
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Zhang Wei <Wei.Zhang@freescale.com>
Subject: Re: fsldma seems to be buggy, noticed in loop mode
Message-ID: <20080313091308.GA17132@Chamillionaire.breakpoint.cc>
References: <20080312180421.GC7255@Chamillionaire.breakpoint.cc>
	<ABF87B0B6A38C0458E319AC973ED68AED32DD2@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <ABF87B0B6A38C0458E319AC973ED68AED32DD2@zch01exm26.fsl.freescale.net>
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

* Zhang Wei | 2008-03-13 15:03:54 [+0800]:

>Could you please apply these two patches and test again?
>
>http://lkml.org/lkml/2008/3/10/64
>http://lkml.org/lkml/2008/3/13/36
Ui, that fast. Did you find this on your own or after me reporting that
bug?
It solves my FIFO problem, thanks.

>Thanks!
>Wei.
 Sebastian
