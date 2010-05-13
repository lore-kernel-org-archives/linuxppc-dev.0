Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 7E8F9B7DEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 21:21:20 +1000 (EST)
Date: Thu, 13 May 2010 04:19:54 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
In-Reply-To: <4BEA5726.50806@nerdbynature.de>
Message-ID: <alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA5726.50806@nerdbynature.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 12 May 2010 at 00:22, Christian Kujau wrote:
> # kexec -e
> Starting new kernel
> Bye!
> 
> ....but then the system just hung there, no more messages, I had to
> powercycle it.

Are there any debug flags (or kernel options?) I can set, to find out why 
it hangs here? Or does kexec not understand zImages?

Thanks,
Christian.
-- 
BOFH excuse #373:

Suspicious pointer corrupted virtual machine
