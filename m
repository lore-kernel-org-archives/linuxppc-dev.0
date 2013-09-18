Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 4559B2C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 02:18:44 +1000 (EST)
Message-ID: <5239D26E.5090505@arm.com>
Date: Wed, 18 Sep 2013 17:18:54 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] move of_find_next_cache_node to DT core
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20130918145116.D53A5C42CDF@trevor.secretlab.ca>
In-Reply-To: <20130918145116.D53A5C42CDF@trevor.secretlab.ca>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/09/13 15:51, Grant Likely wrote:
> On Wed, 18 Sep 2013 11:53:03 +0100, Sudeep KarkadaNagesha <Sudeep.Karkada=
Nagesha@arm.com> wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Hi,
>>
>> The cache bindings are generic and used by many other architectures
>> apart from PPC. These patches fixes and move the existing definition
>> of of_find_next_cache_node to DT common code.
>>
>> Regards,
>> Sudeep
>=20
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>=20
> However, do you have a user for this function on other architectures
> yet? I'd like to see a user for the function in the same patch series..
>=20

Yes I have posted an RFC[1] following this series implementing cacheinfo
for ARM similar to x86 implementation. I was not sure if it's good idea
to combine it as its still initial RFC version.

Regards,
Sudeep

[1] https://lkml.org/lkml/2013/9/18/340
