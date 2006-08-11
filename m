Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 242DE67BD4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 04:32:12 +1000 (EST)
Date: Fri, 11 Aug 2006 13:35:17 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Haruki Dai-r35557 <Dai.Haruki@freescale.com>
Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 :
	differentoutputs
Message-ID: <20060811183517.GA14324@gate.crashing.org>
References: <CFF33627-951D-495D-8DBB-B0AC7F9D13D7@kernel.crashing.org>
	<18AEF66AFDF06F4CAAA1D419D000FD3380B85B@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18AEF66AFDF06F4CAAA1D419D000FD3380B85B@az33exm24.fsl.freescale.net>
Cc: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2006 at 11:08:59AM -0700, Haruki Dai-r35557 wrote:
> Why there are three TSEC on the MPC8540?? 

There aren't.  There are two TSECs and one FEC on the MPC8540.
gianfar drives them all (all the non-CPM enets, that is).

-Matt
