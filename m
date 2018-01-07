Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF5Yy1JVdzF0RC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 04:51:34 +1100 (AEDT)
Subject: Re: Time to get rid of CPU6 ERRATA on powerpc/8xx ?
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
References: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
 <20180107164304.GA21977@gate.crashing.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <61f2b2bb-bdc0-39f5-81df-dc931494bb4b@c-s.fr>
Date: Sun, 7 Jan 2018 18:51:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180107164304.GA21977@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/01/2018 à 17:43, Segher Boessenkool a écrit :
> On Sun, Jan 07, 2018 at 05:23:13PM +0100, christophe leroy wrote:
>> Today, Linux kernel includes a workaround for CPU6 ERRATA on the 8xx
>> powerpc.
>>
>> This ERRATA exists on the 801, the 823, the 855/860 before revision C.0
>> It doesn't concern any modern versions of the 8xx, neither the 860 past
>> and including rev C.0, nor the 866 nor the 885
>>
>> This workaround complicates the TLBmiss and TLBerror handlers and make
>> the code more and more unreadable.
>>
>> Since this workaround addresses very old versions of the 8xx, I'd like
>> to get rid of it. Do you see any good reason to keep it today ? If not I
>> will come with a cleanup patch in the coming weeks.
> 
> What is "very old"?  It'll help if you give some indication.

CPU6 bug is already announced fixed in rev C.0 in revision 1.4 of the 
ERRATA document, issued in August 2000.

> 
> Removing the workarounds is fine by me, of course...  Maybe make it fail
> to boot though, with an error message?  Someone *will* try to run it on
> an old system, *especially* if you think no one would.

Ok, will see how we can do that. It means identifying each revision of 
the chip.

Thanks
Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
