Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 900AA68263
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2005 19:22:12 +1000 (EST)
In-Reply-To: <20050913203555.GB18639@dmt.cnet>
References: <20050913175028.GB14889@dmt.cnet>
	<A6CA30D6-DDC3-4AEF-8CA2-58CFA261F44B@freescale.com>
	<20050913203555.GB18639@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <3af7fefa2343235f0c8e96a426e9a22c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 15 Sep 2005 10:21:52 +0200
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, cort@fsmlabs.com,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: __switch_to test-and-branch ALTIVEC specific?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> This probably has to due with what happens on a G4 system with a
>> kernel not build with Altivec.. However, I dont remember exactly what
>> behavior is desired.

A kernel not build with AltiVec support will just
SIGILL any user process that tries to use it (and
MSR[VEC] = 0).

The code here can safely be #ifdef'ed out (but note
I only looked at the code, I didn't test it ;-) )


Segher
