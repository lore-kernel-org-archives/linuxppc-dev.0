Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 85967DE713
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 05:44:43 +1100 (EST)
Date: Tue, 11 Mar 2008 21:44:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/8] [POWERPC] qe_lib: export qe_get_brg_clk()
Message-ID: <20080311184442.GA32400@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172424.GE7727@localhost.localdomain>
	<7360820C-8025-4797-9E05-B68BD2FC6CE3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <7360820C-8025-4797-9E05-B68BD2FC6CE3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2008 at 01:36:16PM -0500, Kumar Gala wrote:
> 
> On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
> 
> >qe_get_brg_clk() will be used by the fsl_gtm routines.
> 
> What is the GTM code going to be used for?

Freescale QE USB Host Controller. I posted that driver already,
but will resend the updated one soon.

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
