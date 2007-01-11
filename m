Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF296DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Jan 2007 10:53:42 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0BNraBc001002
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Jan 2007 18:53:36 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0BNrabL273594
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Jan 2007 18:53:36 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0BNrZwH019743
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Jan 2007 18:53:35 -0500
Subject: Re: [PATCH] [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adalkk9dx7e.fsf@cisco.com>
References: <adalkk9dx7e.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 17:53:54 -0600
Message-Id: <1168559634.4217.8.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-11 at 14:18 -0800, Roland Dreier wrote:
> Add a cputable entry for revision B of the AMCC 440SPe.  When adding
> this entry, we need to adjust the entry for 440SP Rev. A so that it
> matches more bits of the PVR, since the 440SPe Rev. B has PVR
> 53421891, which would match the old 440SP PVR pattern of 53xxx891.

Is Rev. B the one found on the AMCC Katmai board?

josh
