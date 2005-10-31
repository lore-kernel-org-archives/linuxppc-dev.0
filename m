Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0418E68641
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 03:46:25 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j9VGkKEH112082
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 16:46:20 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP
	id j9VGkK9S225086
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 17:46:20 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j9VGkKSu004465
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 17:46:20 +0100
In-Reply-To: <20051030044256.GA10863@pb15.lixom.net>
References: <20051030044256.GA10863@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <1a5b4360dec1539647aa113dcc60d541@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 31 Oct 2005 17:47:45 +0100
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PPC: Basic enablement for new 15" PowerBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's a qualified guess that the new 17" is PowerBook5,9, but until it's
> confirmed there's not much use in adding it to the pmac_feature table.

It is.  See  
http://developer.apple.com/documentation/Hardware/Developer_Notes/ 
Macintosh_CPUs-G4/17inchPowerBookG4/1Overview/ 
chapter_2_section_6.html#//apple_ref/doc/uid/TP40003166-CH205-TPXREF108


Segher
