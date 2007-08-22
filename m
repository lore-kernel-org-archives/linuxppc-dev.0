Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BBEFDDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 22:43:55 +1000 (EST)
Message-ID: <46CC2FB3.4000200@freescale.com>
Date: Wed, 22 Aug 2007 07:44:35 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
References: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
In-Reply-To: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:

> Scott Wood (15):
>       [POWERPC] Add clrbits8 and setbits8

No love for my similar patch that adds the clrsetbits macros? Or the one that changes immap_86xx.h?
