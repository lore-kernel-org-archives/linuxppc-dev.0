Return-Path: <lee.nipper@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id E44C4B6EFE
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 05:04:26 +1000 (EST)
Received: by gyd5 with SMTP id 5so640658gyd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jul 2010 12:04:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100708182210.GB28969@zod.rchland.ibm.com>
References: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
	<AANLkTikCFgFZsAl0QLkZbI1Jbrh8v0d7gK9EVtqCe1QU@mail.gmail.com>
	<20100708182210.GB28969@zod.rchland.ibm.com>
Date: Thu, 8 Jul 2010 14:04:23 -0500
Message-ID: <AANLkTilHTXhhuN0pB0lbY5Mm48Nbc-leDv6lNiz3Nlvo@mail.gmail.com>
Subject: Re: 405EX Rev D mis-identification?
From: Lee Nipper <lee.nipper@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
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

On Thu, Jul 8, 2010 at 13:22, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote=
:
> On Thu, Jul 08, 2010 at 12:59:29PM -0500, Lee Nipper wrote:
>>On Thu, Jul 8, 2010 at 10:06, Marc Chidester <marcchidester@gmail.com> wr=
ote:
>>
>>> Is there an algorithm update needed or am I missing something?
>>
>>Perhaps add more cpu_spec table entries for the 405EX & 405EXr with
>>pvr_mask =3D 0xffff000f =A0?
>
> Have you tried that in a locally modified kernel? =A0If so, did it work? =
=A0If so,
> care to submit a patch? :)
>

I have not yet.  I will prepare a patch.

Lee
