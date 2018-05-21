Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDnc2ZqTzF132
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 20:01:24 +1000 (AEST)
In-Reply-To: <20180510215919.27808-2-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [1/2] powerpc: flipper-pic: Don't match all IRQ domains
Message-Id: <40qDnc0ywpz9s3Z@ozlabs.org>
Date: Mon, 21 May 2018 20:01:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-10 at 21:59:18 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> On the Wii, there is a secondary IRQ controller (hlwd-pic), so
> flipper-pic's match operation should not be hardcoded to return 1.
> In fact, the default matching logic is sufficient, and we can completely
> omit flipper_pic_match.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c068e6b8caa0c796535cb12f64767c

cheers
