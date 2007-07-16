Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id A9D9CDDF37
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 10:45:39 +1000 (EST)
Date: Mon, 16 Jul 2007 10:45:39 +1000
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
Message-ID: <20070716004539.GS10345@bakeyournoodle.com>
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com>
	<20070712064115.GO10345@bakeyournoodle.com>
	<4696197E.9010002@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4696197E.9010002@genesi-usa.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 12, 2007 at 01:07:26PM +0100, Matt Sealey wrote:

Hi Matt,
 
> What does "isn't quite right yet" mean? Broken, acts funny, or just
> a messy patch?

If you compile with CONFIG_NO_HZ=y, the kernel is broken.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
