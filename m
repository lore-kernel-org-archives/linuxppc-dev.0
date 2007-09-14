Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B225DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 10:32:54 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8F0Wpnu029306
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 20:32:51 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8F0WpTd667704
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 20:32:51 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8F0WpK3009265
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 20:32:51 -0400
Subject: Re: [PATCH] add Kconfig option for optimizing for cell
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200709150221.57825.arnd@arndb.de>
References: <200709150221.57825.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 18:07:44 -0500
Message-Id: <1189811264.24878.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-09-15 at 02:21 +0200, Arnd Bergmann wrote:
> Since the PPE on cell is an in-order core, it suffers significantly
> from wrong instruction scheduling. This adds an Kconfig option that
> enables passing -mtune=cell to gcc in order to generate object
> code that runs well on cell.

Which version of gcc supports that?

josh
