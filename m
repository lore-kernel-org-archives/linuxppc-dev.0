Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 662DA679E0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Aug 2006 23:55:05 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k73Dt1YK018685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Aug 2006 09:55:01 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k73Dt1qv283276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Aug 2006 09:55:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k73Dt16b020872
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Aug 2006 09:55:01 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: IBM OCP GPIO driver for linux 2.6
Date: Thu, 3 Aug 2006 15:54:59 +0200
References: <1154603751.17247.10.camel@jb-portable>
In-Reply-To: <1154603751.17247.10.camel@jb-portable>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608031555.00121.arnd.bergmann@de.ibm.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 03 August 2006 13:15, Jean-Baptiste Maneyrol wrote:
> Let me known if a port exists, or if there is a new way of accessing the
> PPC 405GP GPIO under linux 2.6. Otherwise, I will port this driver using
> the IBM IIC driver as an example (for the things about OCP). In this
> case, do anybody know where I can have the last version of this driver
> (I have v 1.7 (07/25/02)) ? 

The only OCP drivers that exist in the tree are for emac and iic.
Those will probably be converted to use something like of_platform_device
in the future, as soon as 4xx gets converted to arch/powerpc.

If you need to port the driver now, it's probably a good idea to use
a platform_driver instead of an ocp driver for it.

	Arnd <><
