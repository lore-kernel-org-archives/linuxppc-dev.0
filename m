Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 96348DE036
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 00:18:32 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 15 Jan 2009 14:18:28 +0100
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<200811201657.44240.laurentp@cse-semaphore.com>
	<711D3B59-EAA3-4FA7-AD17-1573F8D57600@kernel.crashing.org>
In-Reply-To: <711D3B59-EAA3-4FA7-AD17-1573F8D57600@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901151418.28882.laurentp@cse-semaphore.com>
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

On Thursday 20 November 2008 17:00:54 Kumar Gala wrote:
> On Nov 20, 2008, at 9:57 AM, Laurent Pinchart wrote:
> > On Thursday 20 November 2008 16:32:21 Kumar Gala wrote:
> >> On Nov 20, 2008, at 6:32 AM, Laurent Pinchart wrote:
> >>> Instead of rounding the divider down, improve the baud-rate
> >>> generators
> >>> accuracy by rounding to the nearest integer.
> >>>
> >>> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> >>> ---
> >>> arch/powerpc/sysdev/cpm2.c |    3 ++-
> >>> 1 files changed, 2 insertions(+), 1 deletions(-)
> >>
> >> is this fixing a bug or just making things better?
> >
> > I guess it depends on your definition of bug :-) The problem has
> > always been present in the kernel sources, and people seem to have coped
> > with it until today. It is still a bug in my opinion, but I suppose the
> > patch can wait until 2.6.29 especially if we want to get it tested (it
> > slightly changes baud rates after all).
>
> Ok. I'll put this in the .29 queue.  Can you provide a bit more detail
> on the issue this is resolving.

2.6.29-rc1 is out and I haven't seen the patch being applied anywhere. Is 
there any blocking issue ?

Best regards,

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
