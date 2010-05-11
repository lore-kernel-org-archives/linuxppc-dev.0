Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id CC0EDB7D61
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 04:02:40 +1000 (EST)
Message-ID: <4BE99A7B.8050500@nerdbynature.de>
Date: Tue, 11 May 2010 10:57:15 -0700
From: Christian Kujau <lists@nerdbynature.de>
MIME-Version: 1.0
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
References: <20100511174749.19309.44615.stgit@muvarov>
In-Reply-To: <20100511174749.19309.44615.stgit@muvarov>
Content-Type: text/plain; charset=UTF-8
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru,
	linuxppc-dev@lists.ozlabs.org, horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 11 May 2010 at 21:47, Maxim Uvarov wrote:
> This patch is required in case if you are using new toolchains.

Ah, thanks I was missing (and looking for) crashdump-powerpc.h
already :-)

Christian
-- 
make bzImage, not war
