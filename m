Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5E5CDDF6B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 00:10:57 +1000 (EST)
Date: Thu, 30 Apr 2009 16:10:29 +0200
From: Nick Piggin <npiggin@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
Message-ID: <20090430141029.GG6900@wotan.suse.de>
References: <49F938E4.2030703@in.ibm.com>
	<20090430064127.GF23746@wotan.suse.de>
	<49F973A0.8070106@in.ibm.com> <20090430103528.GA6900@wotan.suse.de>
	<1241087884.19252.5.camel@penberg-laptop>
	<20090430210004.05a61841.sfr@canb.auug.org.au>
	<20090430111825.GC6900@wotan.suse.de>
	<1241090429.19252.7.camel@penberg-laptop>
	<20090430130542.GF6900@wotan.suse.de>
	<20090501000033.ecce9ed8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090501000033.ecce9ed8.sfr@canb.auug.org.au>
Cc: Christoph Lameter <cl@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 01, 2009 at 12:00:33AM +1000, Stephen Rothwell wrote:
> Hi Nick,
> 
> On Thu, 30 Apr 2009 15:05:42 +0200 Nick Piggin <npiggin@suse.de> wrote:
> >
> > Hmm, this might do it. The following code now passes some stress testing
> > in a userspace harness wheras before it did not (and was obviously wrong).
> 
> Indeed that allows it to boot fine.  Thanks.
> 
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

Great, thanks for reporting and testing. This one is especially
important because it is basically scribbling on random memory
:( Pekka, please apply.

Thanks,
Nick
