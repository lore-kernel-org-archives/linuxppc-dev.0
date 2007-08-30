Return-Path: <jschopp@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80FA1DDE45
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:36:39 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7UKaYhw030363
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 16:36:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7UKaY4h673690
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 16:36:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7UKaXPw026697
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 16:36:34 -0400
Message-ID: <46D72A4E.6060106@austin.ibm.com>
Date: Thu, 30 Aug 2007 15:36:30 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Joachim Fenkes <FENKES@de.ibm.com>
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
References: <OF9D1ED44F.896DCCC5-ONC1257347.0044D256-C1257347.004CFB07@de.ibm.com>
In-Reply-To: <OF9D1ED44F.896DCCC5-ONC1257347.0044D256-C1257347.004CFB07@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Paul Mackerras <pmac@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There are currently two GX devices, eHCA and eHEA, which both reside 
> beneath the root node - this is required by architecture for those 
> devices. Unless they invent a device called 
> "supercalifragilisticexpialidocious", devices in the root note will have a 
> full_name of less than 31 chars. Even in that case, the truncation occurs 
> at the beginning, so the @xxx part that makes the nodes unique will stay 
> in place.
> 

OK, didn't realize it had to be beneath the root node, and that the 
truncation truncated the front and not the back.  I would have done it 
differently, but this should work.

Acked-by: Joel Schopp <jschopp@austin.ibm.com>
