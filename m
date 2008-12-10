Return-Path: <dhowells@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id DB908DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 00:10:21 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <5545.1228914404@redhat.com>
References: <5545.1228914404@redhat.com>
	<1795455197.20081210132912@emcraft.com>
	<200812092044.40649.yur@emcraft.com>
	<Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
	<503391615.20081210130113@emcraft.com>
	<20081210101745.GG28946@ZenIV.linux.org.uk>
Subject: Re: Re[2]: [PATCH] fork_init: fix division by zero
Date: Wed, 10 Dec 2008 13:09:38 +0000
Message-ID: <5572.1228914578@redhat.com>
Sender: dhowells@redhat.com
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, Al Viro <viro@ZenIV.linux.org.uk>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Howells <dhowells@redhat.com> wrote:

> Ummm...  On powerpc, I believe rotate-left would be a division as it does the
> bit-numbering and the bit direction the opposite way to more familiar CPUs
> such as x86.

Actually, I'm not sure that's true.  Sometimes powerpc makes my head hurt:-)

David
