Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72930DDFC8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 04:17:19 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0BHH927026191
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 12:17:09 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0BHH98A289674
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 12:17:09 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0BHH8WJ018470
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 12:17:08 -0500
Date: Thu, 11 Jan 2007 11:17:06 -0600
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Message-ID: <20070111171706.GG6177@austin.ibm.com>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	<200701111008.34866.arnd@arndb.de>
	<200701110928.l0B9SUri015056@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701110928.l0B9SUri015056@toshiba.co.jp>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linux-ide@vger.kernel.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 06:30:55PM +0900, Akira Iguchi wrote:
> Hi, Arnd-san.
> 
> Thank you for checking our patches.
> 
> >On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
> >> This patch modifies some static functions in libata-core.c
> >> and libata.h to use them in ata_scc.c.
> >
> >Exporting new symbols needs some explanation here about why they
> >should now be global for ata_scc while the existing drivers
> >did not need them. Since the patch otherwise only moves stuff
> >around as needed, I assume it's good.
> 
> I thought it was better to use common functions as far as possible.

Yes, I agree that it is better to use common functions when possible.

Why is it that other drivers did not need this functions? Did they
copy them?  Or maybe they don't need them?

--linas
