Return-Path: <sebastian@breakpoint.cc>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6C7B2B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 07:33:12 +1000 (EST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0586DDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 07:33:12 +1000 (EST)
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
	(easymta 1.00 BETA 1) id 1MYo6e-0001hc-1H
	for linuxppc-dev@ozlabs.org; Wed, 05 Aug 2009 23:33:08 +0200
Date: Wed, 5 Aug 2009 23:33:08 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: Re: kexec on e300 core / mpc5121
Message-ID: <20090805213308.GC6233@Chamillionaire.breakpoint.cc>
References: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Sebastian Andrzej Siewior | 2009-08-05 01:06:06 [+0200]:
[long mail]
>Does someone have an idea?
Issue fixed, it was the ipic. The missing data while disabling the
caches was my fault because I invalidated the caches before I've flushed
them.

Sebastian
