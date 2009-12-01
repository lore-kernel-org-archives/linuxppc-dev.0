Return-Path: <fche@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 91F311007D3
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Dec 2009 04:54:34 +1100 (EST)
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/8 userland!] systemtap: Add initial support for ppc32
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
From: fche@redhat.com (Frank Ch. Eigler)
Date: Tue, 01 Dec 2009 12:54:32 -0500
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Sat, 28 Nov 2009 01:32:51 +0300")
Message-ID: <y0mr5rewpev.fsf@fche.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, systemtap@sourceware.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> writes:

> Here are some patches that add systemtap support for ppc32 machines.
> [...]

Thanks, committed, with a little extra for ppc64 compatibility.

- FChE
