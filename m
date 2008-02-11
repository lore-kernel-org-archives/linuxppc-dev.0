Return-Path: <haveblue@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33BFADDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 03:04:44 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1BG4fJe028261
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:04:41 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1BG4faC224664
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:04:41 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1BG4ffk017535
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:04:41 -0500
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
From: Dave Hansen <haveblue@us.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200802111657.07534.ossthema@de.ibm.com>
References: <200802111657.07534.ossthema@de.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Feb 2008 08:04:43 -0800
Message-Id: <1202745883.8276.5.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Cc: "Themann, Jan-Bernd" <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-02-11 at 16:57 +0100, Jan-Bernd Themann wrote:
> Drivers like eHEA need memory notifiers in order to 
> update their internal DMA memory map when memory is added
> to or removed from the system.

Could you post this with the new users as well so we can make sure
they're not abusing this in some way?

-- Dave
