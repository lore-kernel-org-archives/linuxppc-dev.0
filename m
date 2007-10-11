Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D75CBDDFD9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:24:52 +1000 (EST)
Date: Thu, 11 Oct 2007 00:30:10 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] move of_platform_driver initialisations:
	arch/powerpc
Message-ID: <20071011053010.GC578@lixom.net>
References: <20071011151903.efa8fdb8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071011151903.efa8fdb8.sfr@canb.auug.org.au>
Cc: Maxim Shchetynin <maxim@de.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>,
	paulus@samba.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 03:19:03PM +1000, Stephen Rothwell wrote:
> We no longer initialise the name and owner fields of the
> of_platform_driver, but use the fields of the embedded device_driver's
> name field instead.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
