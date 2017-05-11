Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNrBX6DBXzDqKF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 21:15:48 +1000 (AEST)
In-Reply-To: <1491381158.28260.36.camel@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/kconfig: Turn CONFIG_RELOCATABLE on
Message-Id: <3wNrBX4yscz9sDF@ozlabs.org>
Date: Thu, 11 May 2017 21:15:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-04 at 08:32:38 UTC, Balbir Singh wrote:
> Most distros will want it on by default and I've missed
> turning it on during developer testing. Having it on ensures
> we are testing our patches with the config enabled.

I agree, but I think we should do it in the defconfigs instead.

cheers
