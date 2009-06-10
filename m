Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AA64AB713B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 08:26:31 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3253DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 08:26:30 +1000 (EST)
Subject: Re: [PATCH 00/33] My PS3-specific patches for 2.6.31
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244671205.29684.1611.camel@localhost.localdomain>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244670213.3352.11.camel@pasglop>
	<1244671205.29684.1611.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 08:26:25 +1000
Message-Id: <1244672785.3352.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 17:00 -0500, Nate Case wrote:
> Hmm, I guess this sorta answers my question to Kumar about my recent
> -next submissions being eligible for 2.6.31.  Sorry for not paying
> closer attention -- I just assumed we weren't even close to the cutoff
> time.  I didn't even see Kumar's "next" branch until April 30th
> (around -rc6..rc7 time I think).
> 
Your patches may still make it, we'll see. Kumar was away for a week
just before the merge window and I started this round's next branch a
bit late, so we can be flexible, it depends how many patches are
involved, how invasive or risky they are etc...

In your case, I'll let Kumar judge.

However, in Geert case, it's a pile of 33 patches sent after the break
point, which is a bit too much over the top :-)

Cheers,
Ben.
