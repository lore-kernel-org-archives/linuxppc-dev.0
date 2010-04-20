Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7A89FB7D0E
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 06:53:24 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: [Bug #15589] 2.6.34-rc1: Badness at fs/proc/generic.c:316
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh> <YeFfFNFyTSF.A.vUB.fSSzLB@tosh>
	<alpine.DEB.2.01.1004192339190.13016@bogon.housecafe.de>
	<1271765898.4324.2.camel@concordia>
	<alpine.DEB.2.01.1004201104170.13016@bogon.housecafe.de>
Date: Tue, 20 Apr 2010 22:53:19 +0200
In-Reply-To: <alpine.DEB.2.01.1004201104170.13016@bogon.housecafe.de>
	(Christian Kujau's message of "Tue, 20 Apr 2010 11:15:05 -0700 (PDT)")
Message-ID: <m2k4s1hmm8.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	adobriyan@gmail.com, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Kujau <lists@nerdbynature.de> writes:

> +	while ((p = strstr(p, "/")))

You want to use strchr.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
