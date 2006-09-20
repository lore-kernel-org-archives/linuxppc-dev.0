Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45F7067B52
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 10:09:17 +1000 (EST)
Subject: Re: [POWERPC] convert string i/o operations to C
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <F3BB850E-E6DD-4CE1-A93B-A56BD2C4B653@kernel.crashing.org>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
	<1158707532.6002.171.camel@localhost.localdomain>
	<F3BB850E-E6DD-4CE1-A93B-A56BD2C4B653@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 10:08:58 +1000
Message-Id: <1158710938.6002.223.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Why?  If "ns" <= 0 there is no I/O done...

For the sake of being paranoid :) What happens on x86 if you do a rep ;
insw with a 0 count ?

Ben.
