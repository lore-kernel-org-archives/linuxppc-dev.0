Return-Path: <R1AAHA@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F397B71B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 05:54:55 +1100 (EST)
Received: from mail87-va3 (localhost [127.0.0.1])	by mail87-va3-R.bigfish.com
 (Postfix) with ESMTP id 8C67C4001EA	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2012 18:54:48 +0000 (UTC)
Received: from VA3EHSMHS012.bigfish.com (unknown [10.7.14.245])	by
 mail87-va3.bigfish.com (Postfix) with ESMTP id 63AA330006A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 18:54:46 +0000 (UTC)
Date: Wed, 8 Feb 2012 12:53:19 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 2/2] powerpc/85xx: update SEC node in
 dts for MPC8572DS
Message-ID: <20120208125319.93ad56b1e04e652fb2848a9a@freescale.com>
In-Reply-To: <4F32A54F.5090305@freescale.com>
References: <1328693276-12057-1-git-send-email-B38951@freescale.com>
 <1328693276-12057-2-git-send-email-B38951@freescale.com>
 <4F32A54F.5090305@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Feb 2012 10:39:43 -0600
Timur Tabi <timur@freescale.com> wrote:

> Jia Hongtao wrote:
> > -/include/ "pq3-sec3.0-0.dtsi"
> > +/include/ "pq3-sec3.1-0.dtsi"
> 
> This is not "adding SEC 3.1 support".  This patch is saying that the 8572
> DTS was using the *wrong* SEC version.  If that's true, you need to
> explain why it was wrong.

especially since, and according to "MPC8572E PowerQUICCTM III
Integrated Host Processor Family Reference Manual, Rev. 2", the 8572
has a SEC 3.0.

Kim
