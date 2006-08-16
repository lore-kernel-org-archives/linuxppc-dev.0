Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 928EA67B57
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 23:15:36 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GDFWrW027582
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 09:15:32 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GDFRhg290270
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 09:15:27 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GDFQbK005773
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 09:15:27 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [POWERPC] iseries: remove some gcc 4.1 warnings
Date: Wed, 16 Aug 2006 15:15:25 +0200
References: <20060816152032.2407a832.sfr@canb.auug.org.au>
In-Reply-To: <20060816152032.2407a832.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608161515.26166.arnd.bergmann@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 August 2006 07:20, Stephen Rothwell wrote:
> gcc 4.1 produces some warnings that it is ignoring the packed attribute
> on some structure elements, so just remove them.
> 

Wouldn't it be nicer to just specify the packed attribute on the
structure instead of each of the members? My reading of the 
gcc documentation is that this is functionally the same, but
it makes the source more readable, aside from avoiding this warning.

	Arnd <><
