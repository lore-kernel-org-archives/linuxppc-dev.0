Return-Path: <srs0=k8tc=ap=russell.cc=ruscur@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt0z06GvHzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 11:18:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xt0z05kf4z8w9G
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 11:18:20 +1000 (AEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xt0z02m6tz9sPk
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2017 11:18:20 +1000 (AEST)
Message-ID: <1505351509.3761.0.camel@russell.cc>
Subject: Re: [PATCH 1/2] powerpc/eeh: Create PHB PEs after EEH is initialized
From: Russell Currey <ruscur@russell.cc>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Date: Thu, 14 Sep 2017 11:11:49 +1000
In-Reply-To: <1504766140.12628.14.camel@kernel.crashing.org>
References: <1504766140.12628.14.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 16:35 +1000, Benjamin Herrenschmidt wrote:
> Otherwise we end up not yet having computed the right
> diag data size on powernv where EEH initialization
> is delayed, thus causing memory corruption later on
> when calling OPAL.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Russell Currey <ruscur@russell.cc>
