Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFCpD2jmxzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 21:31:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: xmon memory dump does not handle LE
In-Reply-To: <d245dc28-5075-8631-4ff1-1039ad88ccd5@linux.vnet.ibm.com>
References: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
 <87a8a4avx3.fsf@concordia.ellerman.id.au>
 <d245dc28-5075-8631-4ff1-1039ad88ccd5@linux.vnet.ibm.com>
Date: Fri, 03 Feb 2017 21:31:30 +1100
Message-ID: <87vasra7lp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Douglas Miller <dougmill@linux.vnet.ibm.com> writes:

> I'm referring to the three commands listed in the help:
>
> d     dump bytes
>
> df    dump float values
>
> dd    dump double values
>
> As it turns out, all three of these commands do exactly the same thing, 
> and it's certainly not what I'd expect based on experience with other 
> debuggers. Maybe the original intent was only to simply output bytes of 
> memory, but to me the help implies otherwise and certainly something 
> more is needed.

OK. I don't think df/dd actually exist in the code, so I think the help
is just out of date, by about 20 years.

'd' definitely works as intended and does what the help says as far as
I'm concerned. The output is pretty similar to hexdump -C for example.

Also xmon isn't a debugger it's a crash handler :)

> I'll take a look at Balbir's patch and see if I can help move it along.

Actually take a look at mine instead.

cheers
