Return-Path: <roland@redhat.com>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by ozlabs.org (Postfix) with ESMTP id E91A1DE581
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 06:55:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
In-Reply-To: Adrian Bunk's message of  Monday, 23 June 2008 20:48:09 +0300
	<20080623174809.GE4756@cs181140183.pp.htv.fi>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Message-Id: <20080627204953.DA76515427E@magilla.localdomain>
Date: Mon, 23 Jun 2008 13:08:51 -0700 (PDT)
Cc: chris@zankel.net, dev-etrax@axis.com, ysato@users.sourceforge.jp,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@linux-mips.org, cooloney@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gerg@uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	yasutake.koichi@jp.panasonic.com, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

That all looks fine to me, though I won't claim to have paid close
attention to the nits in the various odd archs' files.

Thanks,
Roland
