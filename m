Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 762102C03BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 21:32:39 +1100 (EST)
Message-ID: <527231DA.9060002@arm.com>
Date: Thu, 31 Oct 2013 10:32:58 +0000
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] of: move definition of of_find_next_cache_node into
 common code.
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>	
 <1379501585-12532-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1383196834.28909.7.camel@pasglop>
In-Reply-To: <1383196834.28909.7.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
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

Hi Ben,

On 31/10/13 05:20, Benjamin Herrenschmidt wrote:
> On Wed, 2013-09-18 at 11:53 +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Since the definition of_find_next_cache_node is architecture independent=
,
>> the existing definition in powerpc can be moved to driver/of/base.c
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>=20
> I've seen no follow up on that, I'm happy to stick it in powerpc-next
> with some other late stuff.
>=20

Thanks for the follow up. Grant wanted to see usage of this outside PPC and=
 I
pointed him[0] to the RFC[1] I had posted to support cacheinfo on ARM.

These patches are based on v3.12-rc1, let me know if you want me to
rebase/repost on any particular version.

Regards,
Sudeep

[0] http://www.spinics.net/lists/devicetree/msg05174.html
[1] https://lkml.org/lkml/2013/9/18/340
