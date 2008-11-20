Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E5E7FDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:57:47 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 20 Nov 2008 16:57:44 +0100
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<644D289D-7057-44F4-B444-E60402E06912@freescale.com>
In-Reply-To: <644D289D-7057-44F4-B444-E60402E06912@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811201657.44240.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

On Thursday 20 November 2008 16:32:21 Kumar Gala wrote:
> On Nov 20, 2008, at 6:32 AM, Laurent Pinchart wrote:
> > Instead of rounding the divider down, improve the baud-rate generators
> > accuracy by rounding to the nearest integer.
> >
> > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> > ---
> > arch/powerpc/sysdev/cpm2.c |    3 ++-
> > 1 files changed, 2 insertions(+), 1 deletions(-)
>
> is this fixing a bug or just making things better?

I guess it depends on your definition of bug :-) The problem has always been 
present in the kernel sources, and people seem to have coped with it until 
today. It is still a bug in my opinion, but I suppose the patch can wait until 
2.6.29 especially if we want to get it tested (it slightly changes baud rates 
after all).

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
