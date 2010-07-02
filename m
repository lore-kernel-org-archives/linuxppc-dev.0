Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id A28B91007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Jul 2010 17:57:34 +1000 (EST)
Received: from mail39-va3 (localhost.localdomain [127.0.0.1])	by
	mail39-va3-R.bigfish.com (Postfix) with ESMTP id 3B6B712600A2	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2010 07:42:13 +0000 (UTC)
Received: from VA3EHSMHS023.bigfish.com (unknown [10.7.14.238])	by
	mail39-va3.bigfish.com (Postfix) with ESMTP id BC02E10B804F	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2010 07:42:12 +0000 (UTC)
Received: from [43.194.30.232] ([43.194.30.232]:29324 "EHLO
	wymx1.eu.sony.com")	by mx3.eu.sony.com with ESMTP id S54771Ab0GBHlu
	(ORCPT
	<rfc822; linuxppc-dev@lists.ozlabs.org>); Fri, 2 Jul 2010 08:41:50 +0100
Received: from gb-bas-dc-dx1.eu.sony.com ([43.194.30.31]:8761 "EHLO
	gbise0weymsx02.eu.sony.com") by wymx1.eu.sony.com with ESMTP	id
	S54807Ab0GBHlu convert rfc822-to-8bit (ORCPT
	<rfc822; linuxppc-dev@lists.ozlabs.org>); Fri, 2 Jul 2010 08:41:50 +0100
Date: Fri, 2 Jul 2010 09:41:48 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: <geert@sonytel.be>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 16/27] KVM: Move kvm_guest_init out of generic code
In-Reply-To: <1277980982-12433-17-git-send-email-agraf@suse.de>
Message-ID: <alpine.LRH.2.00.1007020937160.17095@mink.sonytel.be>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-17-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 1 Jul 2010, Alexander Graf wrote:
> Currently x86 is the only architecture that uses kvm_guest_init(). With
> PowerPC we're getting a second user, but the signature is different there=

> and we don't need to export it, as it uses the normal kernel init framewo=
rk.

Making the signatures match (i.e. always return `int') wouldn't hurt,
since kvm_guest_init() apparently can fail on x86, too.

> So let's move the x86 specific definition of that function over to the x8=
6
> specfic header file.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium=


Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

************************************************************************
The information contained in this message or any of its attachments may be =
confidential and is intended for the exclusive use of the addressee(s).  An=
y disclosure, reproduction, distribution or other dissemination or use of t=
his communication is strictly prohibited without the express permission of =
the sender.  The views expressed in this email are those of the individual =
and not necessarily those of Sony or Sony affiliated companies.  Sony email=
 is for business use only.

This email and any response may be monitored by Sony to be in compliance wi=
th Sony's global policies and standards
