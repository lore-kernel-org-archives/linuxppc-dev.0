Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 81B1A2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 19:16:41 +1100 (EST)
Message-ID: <1383293781.28909.39.camel@pasglop>
Subject: Re: [PATCH 2/2] of: move definition of of_find_next_cache_node into
 common code.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Date: Fri, 01 Nov 2013 19:16:21 +1100
In-Reply-To: <527231DA.9060002@arm.com>
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1379501585-12532-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1383196834.28909.7.camel@pasglop> <527231DA.9060002@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-31 at 10:32 +0000, Sudeep KarkadaNagesha wrote:

> Thanks for the follow up. Grant wanted to see usage of this outside PPC and I
> pointed him[0] to the RFC[1] I had posted to support cacheinfo on ARM.
> 
> These patches are based on v3.12-rc1, let me know if you want me to
> rebase/repost on any particular version.

I've applied them to powerpc-next

Cheers,
Ben.
