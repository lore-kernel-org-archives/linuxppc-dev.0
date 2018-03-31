Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0Zm4RXVzF1xW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:03:44 +1100 (AEDT)
In-Reply-To: <20180206123707.13715-1-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: powerpc: wii: Probe the whole devicetree
Message-Id: <40D0Zm3JrXz9s2R@ozlabs.org>
Date: Sun,  1 Apr 2018 01:03:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-06 at 12:37:04 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> Previously, wii_device_probe would only initialize devices under the
> /hollywood node. After this patch, platform devices placed outside of
> /hollywood will also be initialized.
> 
> The intended usecase for this are devices located outside of the
> Hollywood chip, such as GPIO LEDs and GPIO buttons.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7ab96c0a083f3a298ae595ea142058

cheers
