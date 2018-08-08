Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltwR6kn3zDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:59 +1000 (AEST)
In-Reply-To: <4c4cb2b4391.4d23d508@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Olof Johansson <olof@lixom.net>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: powerpc/pasemi: Seach for PCI root bus by compatible property
Message-Id: <41ltwQ2tj7z9s3Z@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-25 at 20:55:18 UTC, Darren Stevens wrote:
> Pasemi arch code finds the root of the PCI-e bus by searching the
> device-tree for a node called 'pxp'. But the root bus has a 
> compatible property of 'pasemi,rootbus' so search for that instead.
> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
> Acked-by: Olof Johansson <olof@lixom.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/250a93501d6265bbb9ddf06af25ac9

cheers
