Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 713B36813F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2005 01:10:28 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j7PFAMOI118208
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 15:10:22 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP
	id j7PFAMYi194056
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 17:10:22 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j7PFAMG4025528
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 17:10:22 +0200
In-Reply-To: <20050825051528.GB19792@suse.de>
References: <20050824115452.GA29148@suse.de> <1124922771.5159.134.camel@gaston>
	<20050825045108.GA19792@suse.de> <1124946481.7906.8.camel@gaston>
	<20050825051528.GB19792@suse.de>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <fa2c65db26f3b23efd4a7a38099640d1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 25 Aug 2005 17:10:45 +0200
To: Olaf Hering <olh@suse.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: AC Power handling broken for desktops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Not sure :) I don't fully know how to decode those power things in the
>> device-tree... There are bits in darwin tho.
>
> Maybe just check for !PowerBook and force PMU_PWR_AC_PRESENT in this 
> case.

Or just if battery count is 0, assume AC power ;-)


Segher
