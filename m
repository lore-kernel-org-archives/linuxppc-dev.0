Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8D94B6EF0
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 04:25:15 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o68ILi71019445
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jul 2010 12:21:44 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o68IOv0D095174
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jul 2010 12:24:57 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o68IOuTr013300
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jul 2010 12:24:57 -0600
Date: Thu, 8 Jul 2010 14:24:55 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Lee Nipper <lee.nipper@gmail.com>
Subject: Re: 405EX Rev D mis-identification?
Message-ID: <20100708182455.GC28969@zod.rchland.ibm.com>
References: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
	<AANLkTim8xuZSaDHyxRVqk63PTT66rrR8hUhEDeNzfmKD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTim8xuZSaDHyxRVqk63PTT66rrR8hUhEDeNzfmKD@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 08, 2010 at 11:01:11AM -0500, Lee Nipper wrote:
>On Thu, Jul 8, 2010 at 10:06, Marc Chidester <marcchidester@gmail.com> wrote:
>> It looks like the Rev D version of the 405EX chip without security
>> will be identified as a 405EXr, based on the values in the cpu_specs
>> table.  For 405EX/405EXr the pvr_mask is  0xffff0004 with the
>> pvr_value's as 0x12910004 and 0x12910000 respectively. I see that the
>> Rev D PVR value for the 405EX without security is 0x12911473, which
>> would mask out to the EXr value.
>>
>> Is there an algorithm update needed or am I missing something?
>
>With 405EX Rev D, we have noticed that we must reset our board
>one time after the initial powerup to make the PVR read correctly.
>
>See this post:
>http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/079099.html

That is very very weird.  Have you seen that behavior on multiple Rev D CPUs
or just one board or?

The PVR value should never change, so if you have odd behavior I wonder if the
are silicon bugs in that revision.  Did you happen to ask AMCC about it?

josh
