Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 497371A0620
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 02:17:11 +1000 (AEST)
Date: Thu, 11 Jun 2015 09:17:09 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Cristian Stoica <cristian.stoica@freescale.com>
Cc: horia.geanta@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: support sizes greater than an unsigned long
Message-ID: <20150611161709.GA1143@kroah.com>
References: <1431620684-20123-1-git-send-email-cristian.stoica@freescale.com>
 <1431683064-29584-1-git-send-email-cristian.stoica@freescale.com>
 <55799E38.1000004@freescale.com> <20150611153835.GB5058@kroah.com>
 <5579B2FC.4010008@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5579B2FC.4010008@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2015 at 07:10:36PM +0300, Cristian Stoica wrote:
> On 06/11/2015 06:38 PM, Greg KH wrote:
> > On Thu, Jun 11, 2015 at 05:42:00PM +0300, Cristian Stoica wrote:
> > 
> > Why?
> > 
> 
> This patch matches the input argument "size" of ioremap() with the output of request_mem_region() (which is
> resource_size_t).
> Since the latter is used as input to the former, the types should match (even though mapping more than 4G is not usually
> expected). There are a lot of such differences in the code and this is an attempt to reduce that.

No, why do I care about a ppc-only patch?  There's nothing that I can do
about this, please work with the proper maintainers and don't randomly
poke people who have no responsibility about the code in question as it
doesn't do any good.

greg k-h
