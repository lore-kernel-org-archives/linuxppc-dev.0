Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8E7467A89
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 13:24:09 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jed5w0993z.fsf@sykes.suse.de>
References: <1106011958.4533.25.camel@gaston> <je7jmaurl0.fsf@sykes.suse.de>
	<1106100264.4534.135.camel@gaston> <jemzv584yw.fsf@sykes.suse.de>
	<1106175427.5326.21.camel@gaston> <jehdld7wx0.fsf@sykes.suse.de>
	<1106182915.5294.57.camel@gaston>  <jed5w0993z.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 13:23:53 +1100
Message-Id: <1106187833.5327.62.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-01-20 at 02:34 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> >>     cpufreq: resume failed to assert current frequency is what timing core thinks it is.
> >
> > Weird ... Can you try without cpufreq built in the kernel ?
> 
> I think this message is unrelated to the problem, it occurs with all
> kernels so far.
> 
> > Also what is the exact CPU revision ?
> 
> It's a 750FX revision 1.18.
> 
> > I think you are just experiencing memory corruption...
> 
> Yes, I agree, I get completely different crashes whenever I use a slightly
> different kernel.

It would be interesting to hack around pmac_cache.S and see if you get
it more reliable ...

Ben.
