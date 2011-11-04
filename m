Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.parisc-linux.org",
 Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 795B5B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 01:10:55 +1100 (EST)
Date: Fri, 4 Nov 2011 08:00:51 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Support for multiple MSI interrupts on MPC8377
Message-ID: <20111104140050.GG22937@parisc-linux.org>
References: <FBC631D6B23BAB40AF19415483130F7A6FD458@HBMURBX.hbm.com>
 <1320292282.3852.33.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320292282.3852.33.camel@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, "Giffel, Brad" <Brad.Giffel@hbm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 03, 2011 at 02:51:22PM +1100, Michael Ellerman wrote:
> There is some code in place to support multiple MSI, but only in the
> generic code (drivers/pci/msi.c), and I'm not sure if it's complete.
> There is no arch support, for any arch AFAIK, and certainly not for
> powerpc.

I think there's an ARM or MIPS architecture that implements support for
it ... the x86 support was never merged.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
