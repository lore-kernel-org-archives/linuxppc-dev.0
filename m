Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3BAE67B63
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 09:13:08 +1000 (EST)
Date: Thu, 9 Jun 2005 15:24:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050609182452.GC8125@logos.cnet>
References: <20050609162650.GA8125@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050609162650.GA8125@logos.cnet>
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: 8xx fixes GIT tree
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 09, 2005 at 01:26:50PM -0300, Marcelo Tosatti wrote:
> Hi, 
> 
> I've put up a GIT tree with some 8xx fixes. 
> 
> I plan to continue collecting fixes there - I encourage other folks 
> working with v2.6 on 8xx to join in and contribute.
> 
> Its about time to setup a "TODO" list for v2.6 8xx, a few which I 
> remember from the top of my head:
> 
> - merge CPU15 workaround
> - merge PCMCIA driver
> - merge arch/ppc/8xx_io/fec.c v2.6 update
> - Remove misc-embedded.c
> 
> It should live somewhere in the web (wiki would be ideal).
> 
> It contains the following changes at the moment:

Oh, I forgot to mention the URL - its at:

http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/8xx-fixes/

Web interface at:

http://www.kernel.org/git/?p=linux/kernel/git/marcelo/8xx-fixes;a=summary
