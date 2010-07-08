Return-Path: <lee.nipper@gmail.com>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id D8FD8B6ED0
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 02:01:13 +1000 (EST)
Received: by gxk25 with SMTP id 25so493451gxk.15
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jul 2010 09:01:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
References: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
Date: Thu, 8 Jul 2010 11:01:11 -0500
Message-ID: <AANLkTim8xuZSaDHyxRVqk63PTT66rrR8hUhEDeNzfmKD@mail.gmail.com>
Subject: Re: 405EX Rev D mis-identification?
From: Lee Nipper <lee.nipper@gmail.com>
To: Marc Chidester <marcchidester@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: lee.nipper@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 8, 2010 at 10:06, Marc Chidester <marcchidester@gmail.com> wrot=
e:
> It looks like the Rev D version of the 405EX chip without security
> will be identified as a 405EXr, based on the values in the cpu_specs
> table. =A0For 405EX/405EXr the pvr_mask is =A00xffff0004 with the
> pvr_value's as 0x12910004 and 0x12910000 respectively. I see that the
> Rev D PVR value for the 405EX without security is 0x12911473, which
> would mask out to the EXr value.
>
> Is there an algorithm update needed or am I missing something?

With 405EX Rev D, we have noticed that we must reset our board
one time after the initial powerup to make the PVR read correctly.

See this post:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/079099.html
