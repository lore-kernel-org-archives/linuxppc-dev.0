Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1271DDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Jan 2007 11:14:26 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0C0ENXb027677
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Jan 2007 19:14:23 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0C0ENRF287064
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Jan 2007 19:14:23 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0C0ENYb028001
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Jan 2007 19:14:23 -0500
Subject: Re: [PATCH] [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adalkk99kvm.fsf@cisco.com>
References: <adalkk9dx7e.fsf@cisco.com>
	<1168559634.4217.8.camel@zod.rchland.ibm.com>
	<adalkk99kvm.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 18:14:44 -0600
Message-Id: <1168560884.4217.16.camel@zod.rchland.ibm.com>
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

On Thu, 2007-01-11 at 15:58 -0800, Roland Dreier wrote:
>  > > Add a cputable entry for revision B of the AMCC 440SPe.  When adding
>  > > this entry, we need to adjust the entry for 440SP Rev. A so that it
>  > > matches more bits of the PVR, since the 440SPe Rev. B has PVR
>  > > 53421891, which would match the old 440SP PVR pattern of 53xxx891.
>  >
>  > Is Rev. B the one found on the AMCC Katmai board?
> 
> I would guess so -- it's the current rev.
> 
> I don't have a katmai board (just a yucca reworked with a rev. b chip)

Ok.  I'm supposedly getting a 440SPe board soon, so I guess I'll find
out soon enough.

josh
