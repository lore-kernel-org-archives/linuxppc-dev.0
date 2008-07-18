Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A90DDDF07
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 06:52:52 +1000 (EST)
Date: Fri, 18 Jul 2008 13:52:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Reiser <jreiser@BitWagon.com>
Subject: Re: [PATCH v3] elf loader support for auxvec base platform string
Message-Id: <20080718135244.a8867700.akpm@linux-foundation.org>
In-Reply-To: <4880FDA1.9070307@BitWagon.com>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<20080717000951.5f8cab37.akpm@linux-foundation.org>
	<20080717221932.GL9594@localdomain>
	<20080717154218.8981035c.akpm@linux-foundation.org>
	<487FD74C.4080603@BitWagon.com> <20080718182850.GO9594@localdomain>
	<4880FDA1.9070307@BitWagon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, ntl@pobox.com,
	torvalds@linux-foundation.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Jul 2008 13:31:29 -0700
John Reiser <jreiser@BitWagon.com> wrote:

> Elsewhere, I've staked out use of a new AT_WINE_PRELOAD_INFO
> at 30.  Avoid that one, please. :-)

The reliable way in which to reserve these numbers is to patch the
header file.
