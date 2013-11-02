Return-Path: <grant.likely@secretlab.ca>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF4BA2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Nov 2013 09:37:13 +1100 (EST)
Received: by mail-we0-f169.google.com with SMTP id q58so803887wes.28
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Nov 2013 15:37:09 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] move of_find_next_cache_node to DT core
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <524E9BA9.4000506@arm.com>
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20130918145116.D53A5C42CDF@trevor.secretlab.ca> <5239D26E.5090505@arm.com>
 <524E9BA9.4000506@arm.com>
Date: Sat, 02 Nov 2013 18:06:46 +0000
Message-Id: <20131102180646.1A722C40DDC@trevor.secretlab.ca>
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

On Fri, 04 Oct 2013 11:42:49 +0100, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com> wrote:
> Hi Grant,
> 
> On 18/09/13 17:18, Sudeep KarkadaNagesha wrote:
> > On 18/09/13 15:51, Grant Likely wrote:
> >> On Wed, 18 Sep 2013 11:53:03 +0100, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com> wrote:
> >>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> >>>
> >>> Hi,
> >>>
> >>> The cache bindings are generic and used by many other architectures
> >>> apart from PPC. These patches fixes and move the existing definition
> >>> of of_find_next_cache_node to DT common code.
> >>>
> >>> Regards,
> >>> Sudeep
> >>
> >> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >>
> >> However, do you have a user for this function on other architectures
> >> yet? I'd like to see a user for the function in the same patch series..
> >>
> > 
> > Yes I have posted an RFC[1] following this series implementing cacheinfo
> > for ARM similar to x86 implementation. I was not sure if it's good idea
> > to combine it as its still initial RFC version.
> > 
> 
> Do you prefer to have this a independent change or to go with the cache topology
> support patches[1] on ARM ?

Ben's already picked it up, so I'm fine with it.

g.
