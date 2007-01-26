Return-Path: <michal.k.k.piotrowski@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id BF6D9DDFFD
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 06:04:41 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so759244ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 11:04:39 -0800 (PST)
Message-ID: <45BA50B7.1070205@googlemail.com>
Date: Fri, 26 Jan 2007 20:04:23 +0100
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (part 2)
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070126181132.GN17836@stusta.de>
In-Reply-To: <20070126181132.GN17836@stusta.de>
Content-Type: text/plain; charset=UTF-8
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Livio Soares <livio@eecg.toronto.edu>,
	Uwe Bugla <uwe.bugla@gmx.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, reiserfs-dev@namesys.com,
	alan@lxorguk.ukuu.org.uk, jmorris@namei.org,
	ttb@tentacle.dhs.org, sds@tycho.nsa.gov,
	Nick Piggin <nickpiggin@yahoo.com.au>, David Chinner <dgc@sgi.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	=?UTF-8?B?TWFsdGUgU2NocsO2ZGVy?= <MalteSch@gmx.de>,
	Venkat Yekkirala <vyekkirala@TrustedCS.com>,
	xfs-masters@oss.sgi.com, rml@novell.com,
	Sami Farin <7atbggg02@sneakemail.com>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	linux-ide@vger.kernel.org, petero2@telia.com, netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	B.Zolnierkiewicz@elka.pw.edu.pl, Gerhard Dirschl <gd@spherenet.de>,
	Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Adrian Bunk napisał(a):
> This email lists some known regressions in 2.6.20-rc6 compared to 2.6.19
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : SELinux compile error with CONFIG_XFRM=n
> References : http://lkml.org/lkml/2007/1/25/233
> Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
> Caused-By  : Venkat Yekkirala <vyekkirala@TrustedCS.com>
>              commit 334c85569b8adeaa820c0f2fab3c8f0a9dc8b92e
> Handled-By : Venkat Yekkirala <vyekkirala@TrustedCS.com>
>              David Miller <davem@davemloft.net>
> Status     : problem is being discussed
> 

Venkat Yekkirala has sent me a patch that fixed this build problem.

Thanks!

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
