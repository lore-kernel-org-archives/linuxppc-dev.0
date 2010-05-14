Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 7FF00B7E39
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 10:44:46 +1000 (EST)
Date: Thu, 13 May 2010 17:43:43 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
In-Reply-To: <AANLkTik1aRVvqj871qOmGctuP_WjvSFwhU1w4gpJoqp1@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1005131739060.3356@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA5726.50806@nerdbynature.de>
	<alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
	<AANLkTik1aRVvqj871qOmGctuP_WjvSFwhU1w4gpJoqp1@mail.gmail.com>
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

On Thu, 13 May 2010 at 15:50, Maxim Uvarov wrote:
> zImage should not work with kexec. Only vmlinux.

"should"?

PPC64 has something nice there:

  > kexec/arch/ppc64/kexec-zImage-ppc64.c:
  > fprintf(stderr, "zImage support is still broken\n");

....but I could not figure out where this is called from.

Anyway, tried vmlinux now and it's working, yay!

Thanks a lot, Maxim!

Christian.
-- 
BOFH excuse #363:

Out of cards on drive D:
