Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3519C67A07
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2005 01:00:45 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j57F0cFu109774
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2005 15:00:39 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j57F0cTa180636
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2005 17:00:38 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j57F0Wvi020178
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2005 17:00:36 +0200
In-Reply-To: <42A5B3E6.9030401@nortel.com>
References: <42A5B3E6.9030401@nortel.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <4b474e026a1d6040f1ec24466d8ff6a8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 7 Jun 2005 17:00:49 +0200
To: Chris Friesen <cfriesen@nortel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: syntax for clobber list with inline assembly
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm writing some inline assembly for ppc.  To specify that r3 is used, 
> I know I need to list it in the clobbered list.
>
> When doing this, do I specify it as "3" or "r3", or are both valid?

Both work.


Segher
