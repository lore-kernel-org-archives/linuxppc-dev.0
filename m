Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id D2029DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 18:09:06 +1100 (EST)
Date: Thu, 7 Feb 2008 00:49:34 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: asm-offsets.c
Message-ID: <20080207064934.GC14201@localdomain>
References: <47AA8C7D.3030109@pikatech.com> <20080207045129.GA4324@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080207045129.GA4324@lst.de>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Wed, Feb 06, 2008 at 11:43:41PM -0500, Sean MacLennan wrote:
> > I just did a git pull of Josh's tree, and 
> > arch/powerpc/kernel/asm-offsets.c does not compile. I have only been 
> > glossing over the linuxppc-dev emails, so forgive me if this already 
> > came up.
> 
> I have the same problem with current powerpc.git.

What are the exact error and config?  I haven't been able to reproduce
this with several defconfigs and toggling CONFIG_HIGH_RES_TIMERS.
