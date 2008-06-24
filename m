Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B3F8DE0DB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 22:29:35 +1000 (EST)
Date: Tue, 24 Jun 2008 14:29:29 +0200
From: Adrian Reber <adrian@lisas.de>
To: Jeremy Kerr <jk@ozlabs.org>,
	Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: starting with 2.6.26-rc1 cell_defconfig fails on QS22
Message-ID: <20080624122929.GA10666@lisas.de>
References: <20080623094539.GA16685@lisas.de>
	<200806240945.33255.jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200806240945.33255.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2008 at 09:45:32AM +1000, Jeremy Kerr wrote:
> > Somehow I expect that I am doing something wrong, because nobody else
> > has reported something like this yet.
> 
> Seems to work fine here - just booted 945754a on a QS22 with 
> cell_defconfig:
> 
> [jk@qs22 ~]$ cat /proc/version
> Linux version 2.6.26-rc7-09992-g945754a (jk@build) (gcc version 4.1.3 
> 20080114 (prerelease) (Debian 4.1.2-19)) #154 SMP Tue Jun 24 09:32:59 
> EST 2008
> 
> Reverting that commit definitely fixes the problem for you? Perhaps a 
> binutils problem then?

D'oh. I spent so much time and the solution is so easy.

Thanks everybody. I have updated to binutils-2.18.50.0.6-2.ppc and now
it works again on QS22 and JS21.

		Adrian
