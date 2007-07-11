Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C3E0DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:32:48 +1000 (EST)
Message-ID: <4694F81A.4010708@freescale.com>
Date: Wed, 11 Jul 2007 10:32:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
	<18066.63111.703924.714899@cargo.ozlabs.ibm.com>
	<A6BAF4A2-B82D-4A69-A4AD-AE797DAE531C@kernel.crashing.org>
In-Reply-To: <A6BAF4A2-B82D-4A69-A4AD-AE797DAE531C@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> Actually I see no good reason to enforce no-exec at all if we can't do
>> it consistently.  And if we're not going to enforce it then there is
>> no point whinging about it.
> 
> 
> I have a new patch with just this behaviour, Scott is
> testing it on old glibc (I think it succeeded, need
> confirmation though),

It worked fine on glibc 2.2.5 and 2.3.3 (the former of which failed 
without the patch).

-Scott
