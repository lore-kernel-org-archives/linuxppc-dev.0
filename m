Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 1AC352C03D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 20:42:45 +1000 (EST)
Message-ID: <524E9BA9.4000506@arm.com>
Date: Fri, 04 Oct 2013 11:42:49 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] move of_find_next_cache_node to DT core
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20130918145116.D53A5C42CDF@trevor.secretlab.ca> <5239D26E.5090505@arm.com>
In-Reply-To: <5239D26E.5090505@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On 18/09/13 17:18, Sudeep KarkadaNagesha wrote:
> On 18/09/13 15:51, Grant Likely wrote:
>> On Wed, 18 Sep 2013 11:53:03 +0100, Sudeep KarkadaNagesha <Sudeep.Karkad=
aNagesha@arm.com> wrote:
>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>
>>> Hi,
>>>
>>> The cache bindings are generic and used by many other architectures
>>> apart from PPC. These patches fixes and move the existing definition
>>> of of_find_next_cache_node to DT common code.
>>>
>>> Regards,
>>> Sudeep
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> However, do you have a user for this function on other architectures
>> yet? I'd like to see a user for the function in the same patch series..
>>
>=20
> Yes I have posted an RFC[1] following this series implementing cacheinfo
> for ARM similar to x86 implementation. I was not sure if it's good idea
> to combine it as its still initial RFC version.
>=20

Do you prefer to have this a independent change or to go with the cache top=
ology
support patches[1] on ARM ?

Regards,
Sudeep

[1] https://lkml.org/lkml/2013/9/18/340
