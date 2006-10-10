Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 48E9967C27
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:01:06 +1000 (EST)
Date: Tue, 10 Oct 2006 14:00:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 0/21]: powerpc/cell spidernet bugfixes, etc.
Message-Id: <20061010140037.274d2c6f.akpm@osdl.org>
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Oct 2006 15:49:47 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> 
> Andrew, please apply/forward upstream.

s/Andrew/Jeff/;)

> I tried to base these on linux-2.6.19-rc1-mm1 but hit a 
> kernel BUG in copy_fdtable at fs/file.c:138! 
> (reported earlire today by Olof)

yup,
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/hot-fixes/
holds what should be a fix.
