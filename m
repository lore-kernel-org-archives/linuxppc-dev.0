Return-Path: <SRS0+3a3b73cd5a4912475f9e+618+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 486AD679FA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2005 18:36:35 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1115072133.6031.33.camel@gaston>
References: <1115072133.6031.33.camel@gaston>
Content-Type: text/plain
Date: Tue, 03 May 2005 09:36:17 +0100
Message-Id: <1115109378.8508.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-05-03 at 08:15 +1000, Benjamin Herrenschmidt wrote:
> For those who can't dare experimenting with that new git toy, best may
> be for you to wait for 2.6.12-rc4 which will contain all of these.

The latest Fedora Core kernel from
http://people.redhat.com/davej/kernels/Fedora/FC4/RPMS.kernel/ ought to
contain them all too, along with a fix for the EHCI port power switching
problem.

-- 
dwmw2
