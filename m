Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54DEC1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 10:09:50 +1100 (AEDT)
In-Reply-To: <1452616757.29488.10.camel@oc7878010663>
References: <568C272D.6000705@linux.vnet.ibm.com>
 <87egdsi4om.fsf@totoro.br.ibm.com> <1452267366.5201.12.camel@vnet.ibm.com>
 <568FE3D0.7080008@linaro.org> <87wprgdu3u.fsf@totoro.br.ibm.com>
 <5693C861.9030308@redhat.com> <87bn8revra.fsf@totoro.br.ibm.com>
 <56941532.9030800@redhat.com> <1452616757.29488.10.camel@oc7878010663>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Add hwcap2 bits for POWER9
From: Michael Ellerman <michael@ellerman.id.au>
Date: Sat, 16 Jan 2016 10:09:46 +1100
To: munroesj@linux.vnet.ibm.com,Carlos O'Donell <carlos@redhat.com>
CC: linuxppc-dev@lists.ozlabs.org, libc-alpha@sourceware.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>
Message-ID: <5139FAF1-9063-4631-BF80-D11A58670953@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13 January 2016 03:39:17 GMT+11:00, Steven Munroe <munroesj@linux.vnet.ibm.com> wrote:
>On Mon, 2016-01-11 at 15:48 -0500, Carlos O'Donell wrote:
>> On 01/11/2016 02:55 PM, Tulio Magno Quites Machado Filho wrote:
>> > "Carlos O'Donell" <carlos@redhat.com> writes:
>> > 
>> >> On 01/11/2016 10:16 AM, Tulio Magno Quites Machado Filho wrote:
>> >>> Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
>> >>>
>> >>>> On 08-01-2016 13:36, Peter Bergner wrote:
>> >>>>> On Fri, 2016-01-08 at 11:25 -0200, Tulio Magno Quites Machado
>Filho wrote:
>> >>>>>> Peter, this solves the issue you reported previously [1].
>> >>>>>>
>> >>>>>> [1] https://sourceware.org/ml/libc-alpha/2015-12/msg00522.html
>> >>>>>
>> >>>>> Agreed, thanks.  I'll also add the POWER9 support to the GCC
>side
>> >>>>> of the patch now that the glibc code is upstream.
>> >>>>
>> >>>> I do not see these bits being added in kernel side yet and GLIBC
>usual
>> >>>> only sync these kind of bits *after* they are included in kernel
>side.
>> >>>> So I would advise to either get these pieces (kernel support and
>hwcap
>> >>>> advertise) in kernel before 2.23 release, otherwise revert the
>patches.
>> >>>
>> >>> Ack.
>> >>> It has just been sent to the correspondent Linux mailing list:
>> >>>
>https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-January/137763.html
>> >>
>> >> Please revert the changes from glibc until you checkin support to
>linux
>> >> kernel mainline.
>> >>
>> >> Leaving these bits in increases the risk that someone uses to
>deploy a glibc
>> >> that then may have the wrong value.
>> > 
>> > Could you clarify this statement, please?
>> > I fail to see how they could have the wrong value.
>> 
>> Until it is checked into the mainline kernel it is not canonical.
>> 
>> That's the rule. There are no other discussions to be had.
>> 
>Well is was posted to to powerpc next:
>https://git.kernel.org/powerpc/c/e708c24cd01ce80b1609d8bacc

And it is now in Linus' tree:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e708c24cd01ce80b1609d8baccee40ccc3608a01

cheers
