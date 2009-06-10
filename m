Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C2E24B716D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 08:00:15 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5626FDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 08:00:13 +1000 (EST)
Subject: Re: [PATCH 00/33] My PS3-specific patches for 2.6.31
From: Nate Case <ncase@xes-inc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1244670213.3352.11.camel@pasglop>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244670213.3352.11.camel@pasglop>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 17:00:05 -0500
Message-Id: <1244671205.29684.1611.camel@localhost.localdomain>
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

On Thu, 2009-06-11 at 07:43 +1000, Benjamin Herrenschmidt wrote:
> Grrrr.....
> 
> It's -WAY TOO LATE-
> 
> I though I made it clear that patches should be ready in -next
> -before- the merge window, in fact, by rc7 or rc8, we should have a
> good idea of what's going in either via my 'next' branch or pending
> stuff in patchwork.
> 
> I'll go through your pile and may still merge it this time around, but
> you should be more proactive at feeding me with that stuff before it's
> merge time.

Hmm, I guess this sorta answers my question to Kumar about my recent
-next submissions being eligible for 2.6.31.  Sorry for not paying
closer attention -- I just assumed we weren't even close to the cutoff
time.  I didn't even see Kumar's "next" branch until April 30th (around
-rc6..rc7 time I think).

-- 
Nate Case <ncase@xes-inc.com>
