Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3DABADDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 03:10:01 +1000 (EST)
Date: Mon, 9 Jul 2007 12:21:23 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 01/35] pasemi: rename platform
Message-ID: <20070709172123.GB7083@lixom.net>
References: <20070705170233.258351000@lixom.net>
	<20070705170233.671358000@lixom.net>
	<20070709095259.0720669b.sfr@canb.auug.org.au>
	<20070709001835.GA30821@lixom.net>
	<20070709172302.149e3fe0.sfr@canb.auug.org.au>
	<20070709171925.GA7083@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070709171925.GA7083@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2007 at 12:19:26PM -0500, Olof Johansson wrote:
> Yeah sure, but not enough to repost the patch. The only problem it causes
> is that a driver introduced a little earlier (but in the same release)
> won't probe until this is applied.

Well, the SDC drivers are affected too (RNG, cpufreq). Still, there aren't
enough mainline users of the platform for it to be a concern at this time.


-Olof
