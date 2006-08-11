Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 00FCA67B8C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 01:55:02 +1000 (EST)
Date: Fri, 11 Aug 2006 10:54:58 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Brent Cook <bcook@bpointsys.com>
Subject: Re: Realtime preemption patch on PPC
Message-Id: <20060811105458.047f95ac.kim.phillips@freescale.com>
In-Reply-To: <200608110938.45385.bcook@bpointsys.com>
References: <1155251072.5950.80.camel@localhost>
	<200608110938.45385.bcook@bpointsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 11 Aug 2006 09:38:45 -0500
Brent Cook <bcook@bpointsys.com> wrote:

> On Thursday 10 August 2006 18:04, Ben Weintraub wrote:

> I have gotten them to work with MPC7448 boards, but it has hardware floating 
> point, so no math-emu problems.
> 
> > Anyhow, when I boot on an MPC8555 with my hack, I get an endless stream
> > of:

if you can, you might want to rebuild your binaries with -msoft-float

Kim
