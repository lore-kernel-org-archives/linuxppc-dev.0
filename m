Return-Path: <pacman@shell01.TheWorld.com>
Received: from TheWorld.com (pcls5.std.com [192.74.137.145])
	by ozlabs.org (Postfix) with ESMTP id 38D72DDEC8
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 16:45:39 +1000 (EST)
From: Alan Curry <pacman@TheWorld.com>
Message-Id: <200707250645.l6P6jYnk1373598@shell01.TheWorld.com>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 25 Jul 2007 02:45:34 -0400 (EDT)
In-Reply-To: <1185344548.5439.308.camel@localhost.localdomain> from "Benjamin
	Herrenschmidt" at Jul 25, 2007 04:22:28 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes the following:
>
>Doesn't it have something in "compatible" instead ? that would be the
>way to go.
>

Assuming that would be represented as a file named "compatible" in the
directory /proc/device-tree/*/*/8042@i60 ... no, it doesn't have one of
those.

For the amusement of all, I offer the entire device-tree as presented in
/proc by my running 2.6.22.1 kernel. Available for a limited time from
http://world.std.com/~pacman/pegasosII_proc_device-tree.tar.gz

-- 
Alan Curry
pacman@world.std.com
