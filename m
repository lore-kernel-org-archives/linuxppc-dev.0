Return-Path: <marcchidester@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id 87B21B6EF7
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 05:56:32 +1000 (EST)
Received: by wwb28 with SMTP id 28so2132901wwb.21
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jul 2010 12:56:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100708182455.GC28969@zod.rchland.ibm.com>
References: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
	<AANLkTim8xuZSaDHyxRVqk63PTT66rrR8hUhEDeNzfmKD@mail.gmail.com>
	<20100708182455.GC28969@zod.rchland.ibm.com>
Date: Thu, 8 Jul 2010 15:56:30 -0400
Message-ID: <AANLkTimtuOOiFh-b7Wi6RLLIV_M93Y7Fpxv8BpwXoLWw@mail.gmail.com>
Subject: Re: 405EX Rev D mis-identification?
From: Marc Chidester <marcchidester@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Lee Nipper <lee.nipper@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 8, 2010 at 2:24 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wro=
te:
> On Thu, Jul 08, 2010 at 11:01:11AM -0500, Lee Nipper wrote:
>>On Thu, Jul 8, 2010 at 10:06, Marc Chidester <marcchidester@gmail.com> wr=
ote:
>>> It looks like the Rev D version of the 405EX chip without security
>>> will be identified as a 405EXr, based on the values in the cpu_specs
>>> table. =A0For 405EX/405EXr the pvr_mask is =A00xffff0004 with the
>>> pvr_value's as 0x12910004 and 0x12910000 respectively. I see that the
>>> Rev D PVR value for the 405EX without security is 0x12911473, which
>>> would mask out to the EXr value.
>>>
>>> Is there an algorithm update needed or am I missing something?
>>
>>With 405EX Rev D, we have noticed that we must reset our board
>>one time after the initial powerup to make the PVR read correctly.
>>
>>See this post:
>>http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/079099.html
>
> That is very very weird. =A0Have you seen that behavior on multiple Rev D=
 CPUs
> or just one board or?
>
> The PVR value should never change, so if you have odd behavior I wonder i=
f the
> are silicon bugs in that revision. =A0Did you happen to ask AMCC about it=
?
>
> josh
>

Check the recent Errata for the chip on this issue.
