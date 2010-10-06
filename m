Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D585BB70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 12:04:40 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9614cHP006845
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Oct 2010 12:04:38 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9614eWw3199038
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Oct 2010 12:04:40 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9614dSc032157
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Oct 2010 12:04:39 +1100
Content-Type: text/plain; charset=UTF-8
Subject: Re: Introduce support for little endian PowerPC
From: Ian Munsie <imunsie@au1.ibm.com>
To: Josh Boyer <jwboyer@gmail.com>
In-reply-to: <AANLkTikHcoccu-WGtSOSdkwU6Tw_An_VFkUcEoY==8=c@mail.gmail.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<AANLkTikHcoccu-WGtSOSdkwU6Tw_An_VFkUcEoY==8=c@mail.gmail.com>
Date: Wed, 06 Oct 2010 12:04:40 +1100
Message-Id: <1286325582-sup-5109@au1.ibm.com>
Cc: paulus <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Josh,

Excerpts from Josh Boyer's message of Fri Oct 01 21:36:35 +1000 2010:
> Aside from my general "uh, why?" stance, I'm very very hesitant to
> integrate anything in the kernel that doesn'.t have released patches
> on the toolchain side.

As I said the kernel can be built today with an unpatched toolchain
targetted at powerpcle-elf, the new powerpcle-linux target is mainly
required for userspace, but yes I want to get those patches out as soon
as possible.

> Also, which uClibc?  The old and crusty uClibc that uses the horrible
> linuxthreads, or the somewhat less crusty that just switched to NPTL
> (which hasn't been verified on normal PowerPC that I recall).  Why not
> use glibc...

As Ben said this was for a proof of concept and changing uClibc to
support it was quite literally a one line change.

I've been using stable packages as my base on the toolchain side of
things (gcc 4.4.4, binutils 2.20.1 and uClibc 0.9.31) so uClibc is still
using linuxthreads since they haven't released a version with NPTL yet.

> I'm not meeting to detract here, but the Kconfig should be dependent
> on && BROKEN until the above is fixed.

Good point.


Cheers,
-Ian
