Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18D1CDDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 22:37:04 +1000 (EST)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
In-Reply-To: Your message of "Sun, 21 Oct 2007 07:30:45 +0200."
	<20d6133a9294d4f06a7e78ca627ec4f3@kernel.crashing.org>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20d6133a9294d4f06a7e78ca627ec4f3@kernel.crashing.org>
Date: Mon, 22 Oct 2007 07:36:57 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IjwWf-0000dJ-45@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> > Property names have been limited to start with
> > characters from the set [a-zA-Z,._#?].  That is, the
> > digits and the expression symbols have been removed.
> 
> This cannot work; many property names start with a digit,
> for example.

Are any of those property names in use in any
of our DTS files or b-w-o.txt?  Not really, no.
In fact, with this lexical change, all of our
DTS files still produce byte-identical results.

I really think this is one of those areas where
we may need to stray from the other guideline.

Is there a compelling reason somewhere?  Really?

jdl
