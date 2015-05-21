Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A14D1A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:51:42 +1000 (AEST)
Date: Thu, 21 May 2015 12:51:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [PATCH 1/1] KVM: PPC: Book3S: correct width in XER handling
Message-ID: <20150521025109.GA12975@drongo.ozlabs.ibm.com>
References: <d0600fe7952351dfd176c97d416a6a351812a78b.1432099563.git.sam.bobroff@au1.ibm.com>
 <1432161308.27761.116.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432161308.27761.116.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 05:35:08PM -0500, Scott Wood wrote:
> 
> It's nominally a 64-bit register, but the upper 32 bits are reserved in
> ISA 2.06.  Do newer ISAs or certain implementations define things in the
> upper 32 bits, or is this just about the asm accesses being wrong on
> big-endian?

It's primarily about the asm accesses being wrong.

Paul.
