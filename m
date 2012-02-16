Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A80AFB6F13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 20:05:51 +1100 (EST)
Received: from mail31-tx2 (localhost [127.0.0.1])	by mail31-tx2-R.bigfish.com
 (Postfix) with ESMTP id B7E411340474	for
 <linuxppc-dev@lists.ozlabs.org>;
 Thu, 16 Feb 2012 09:05:46 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.246])	by
 mail31-tx2.bigfish.com (Postfix) with ESMTP id 6611D15C004A	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 09:05:44 +0000 (UTC)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Phillips Kim-R1AAHA <R1AAHA@freescale.com>, Tabi Timur-B04825
 <B04825@freescale.com>
Subject: RE: [linuxppc-release] [PATCH 2/2] powerpc/85xx: update SEC node in
 dts for MPC8572DS
Date: Thu, 16 Feb 2012 09:05:42 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D019B0612@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1328693276-12057-1-git-send-email-B38951@freescale.com>
 <1328693276-12057-2-git-send-email-B38951@freescale.com>
 <4F32A54F.5090305@freescale.com>
 <20120208125319.93ad56b1e04e652fb2848a9a@freescale.com>
In-Reply-To: <20120208125319.93ad56b1e04e652fb2848a9a@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

You are right, I copied the patch from 2.6 without doing confirm.
I will remove this patch.

Thanks.

-----Original Message-----
From: Phillips Kim-R1AAHA=20
Sent: Thursday, February 09, 2012 2:53 AM
To: Tabi Timur-B04825
Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org
Subject: Re: [linuxppc-release] [PATCH 2/2] powerpc/85xx: update SEC node i=
n dts for MPC8572DS

On Wed, 8 Feb 2012 10:39:43 -0600
Timur Tabi <timur@freescale.com> wrote:

> Jia Hongtao wrote:
> > -/include/ "pq3-sec3.0-0.dtsi"
> > +/include/ "pq3-sec3.1-0.dtsi"
>=20
> This is not "adding SEC 3.1 support".  This patch is saying that the=20
> 8572 DTS was using the *wrong* SEC version.  If that's true, you need=20
> to explain why it was wrong.

especially since, and according to "MPC8572E PowerQUICCTM III Integrated Ho=
st Processor Family Reference Manual, Rev. 2", the 8572 has a SEC 3.0.

Kim
