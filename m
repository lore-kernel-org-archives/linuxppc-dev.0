Return-Path: <lsorense@csclub.uwaterloo.ca>
Received: from caffeine.csclub.uwaterloo.ca (caffeine.uwaterloo.ca
	[129.97.134.17]) by ozlabs.org (Postfix) with ESMTP id 26440DDE31
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 03:39:01 +1100 (EST)
Date: Wed, 24 Jan 2007 11:06:31 -0500
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.20-rc5: known unfixed regressions (v3) (part 2)
Message-ID: <20070124160631.GE7582@csclub.uwaterloo.ca>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
	<20070124154725.GK17836@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070124154725.GK17836@stusta.de>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: Andrew Morton <akpm@osdl.org>, Livio Soares <livio@eecg.toronto.edu>,
	Uwe Bugla <uwe.bugla@gmx.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, alan@lxorguk.ukuu.org.uk,
	takada <takada@mbf.nifty.com>, ttb@tentacle.dhs.org,
	jgarzik@pobox.com, Nick Piggin <nickpiggin@yahoo.com.au>,
	Malte Schr??der <MalteSch@gmx.de>, David Chinner <dgc@sgi.com>,
	xfs-masters@oss.sgi.com, Linus Torvalds <torvalds@osdl.org>,
	rml@novell.com, Sami Farin <7atbggg02@sneakemail.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	linux-ide@vger.kernel.org, petero2@telia.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jordan Crouse <jordan.crouse@amd.com>, gd@spherenet.de,
	Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>, reiserfs-dev@namesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 04:47:25PM +0100, Adrian Bunk wrote:
> Subject    : fix geode_configure()
> References : http://lkml.org/lkml/2007/1/9/216
> Submitter  : Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Caused-By  : takada <takada@mbf.nifty.com>
>              commit e4f0ae0ea63caceff37a13f281a72652b7ea71ba
> Handled-By : takada <takada@mbf.nifty.com>
>              Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Status     : patches are being discussed

I wouldn't call this a regression.  It appears to go way back.  I also
didn't find it, I just commented on it since it does affect the platform
I work on.

--
Len Sorensen
