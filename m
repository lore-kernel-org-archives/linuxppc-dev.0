Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD7C1DDF03
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 17:13:54 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18518.114.100584.607669@cargo.ozlabs.ibm.com>
References: <18518.114.100584.607669@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 17:13:22 +1000
Message-Id: <1213600402.8129.127.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-16 at 15:56 +1000, Paul Mackerras wrote:
> Please pull from the 'merge' branch of
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> to get some more bug fixes and defconfig updates for powerpc, as
> listed below.  Almost all of the bulk is in the defconfig updates for
> the Freescale embedded platforms.

Paul, did you have a chance to fix our defconfig's for the loss of
SFF support in libata ?

Cheers,
Ben.
