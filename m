Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FDCBDDF0A
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 19:42:47 +1100 (EST)
Subject: Re: 2.6.27 g5 config?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <48F151FD.4040805@hypersurf.com>
References: <48F151FD.4040805@hypersurf.com>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 19:42:39 +1100
Message-Id: <1223887359.8157.247.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-10-11 at 18:25 -0700, Kevin Diggs wrote:
> Hi,
> 
> 	I always have trouble getting an initial build to boot. Usually
> it is with keyboards and video console. Currently, I can't seem to find
> the root disk.

Why don't you just use a g5_defconfig ?

Ben.
