Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F8AE1007D4
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jul 2011 11:39:48 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: RFC: top level compatibles for virtual platforms
Date: Sat, 9 Jul 2011 01:39:26 +0000
Message-ID: <CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 8, 2011 at 1:43 PM, Yoder Stuart-B08248
<B08248@freescale.com> wrote:

> =A0 "MPC85xxDS" - for a virtual machine for the e500v2 type platforms
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and would support 85xx targets, plus P202=
0, P1022,etc
>
> =A0 "corenet-32-ds" - for a virtual machine similar to the 32-bit P4080
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platforms
>
> =A0 "corenet-64-ds" - for a virtual machine based on a 64-bit corenet
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform

I think we should drop the "DS" because that's a name applied to
certain Freescale reference boards.

Is being a CoreNet board really something meaningful with respect to
KVM?  I don't see the connection.

Also, if these are KVM creations, shouldn't there be a "kvm" in the
compatible string somewhere?

--=20
Timur Tabi
Linux kernel developer at Freescale=
