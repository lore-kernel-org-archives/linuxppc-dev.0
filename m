Return-Path: <segher@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4D280B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 06:15:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87AA6DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 06:15:16 +1000 (EST)
In-Reply-To: <19062.57005.981901.24666@cargo.ozlabs.ibm.com>
References: <4A76DB06.7090405@gmail.com>
	<19062.57005.981901.24666@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3136FD0E-6C97-4F03-80B9-0F509FA3CEAF@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Read buffer overflow
Date: Mon, 3 Aug 2009 22:15:30 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Roel Kluin <roel.kluin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The change seems unnecessary since we only compute the address of the
> element before the bounds check, we don't actually access the
> element.  I believe that is legal in C.

If you have an array a[N], taking &a[0] .. &a[N] are legal C, everything
else is not.


Segher
