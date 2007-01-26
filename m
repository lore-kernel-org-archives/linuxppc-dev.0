Return-Path: <andrew@digital-domain.net>
Received: from smtp.aaisp.net.uk (smtp.aaisp.net.uk [81.187.81.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FB5FDE06B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 22:49:12 +1100 (EST)
Date: Fri, 26 Jan 2007 11:13:09 +0000
From: Andrew Clayton <andrew@digital-domain.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.20-rc5: known unfixed regressions (v3) (part 2)
Message-ID: <20070126111309.1732d727@zeus.pccl.info>
In-Reply-To: <20070124154725.GK17836@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
	<20070124154725.GK17836@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, Sami, Trond,
	Livio Soares <livio@eecg.toronto.edu>,
	Uwe Bugla <uwe.bugla@gmx.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, alan@lxorguk.ukuu.org.uk,
	takada <takada@mbf.nifty.com>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	ttb@tentacle.dhs.org, jgarzik@pobox.com,
	Nick Piggin <nickpiggin@yahoo.com.au>, David Chinner <dgc@sgi.com>,
	Malte =?UTF-8?B?U2NocsO2ZGVy?= <MalteSch@gmx.de>,
	gd@spherenet.de, xfs-masters@oss.sgi.com,
	Linus Torvalds <torvalds@osdl.org>, rml@novell.com,
	Farin <7atbggg02@sneakemail.com>, "Vladimir V. Saveliev" <vs@namesys.com>,
	linux-ide@vger.kernel.org, petero2@telia.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Myklebust <trond.myklebust@fys.uio.no>,
	Jordan Crouse <jordan.crouse@amd.com>, Linux,
	Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>, reiserfs-dev@namesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Jan 2007 16:47:25 +0100, Adrian Bunk wrote:

> 
> 
> Subject    : NFS triggers WARN_ON() in invalidate_inode_pages2_range()
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7826
> Submitter  : Andrew Clayton <andrew@digital-domain.net>
> Caused-By  : Andrew Morton <akpm@osdl.org>
>              commit 8258d4a574d3a8c01f0ef68aa26b969398a0e140
> Handled-By : Trond Myklebust <trond.myklebust@fys.uio.no>
> Status     : Trond: the WARN_ON() needs to be thrown out
> 

Still present in -rc6
