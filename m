Return-Path: <dedekind@infradead.org>
Subject: Re: [PATCH 0/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
From: Artem Bityutskiy <dedekind@infradead.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200904161405.04100.sr@denx.de>
References: <200904161405.04100.sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Apr 2009 15:19:04 +0300
Message-Id: <1239884344.3390.213.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linux-mtd@lists.infradead.org
Reply-To: dedekind@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 14:05 +0200, Stefan Roese wrote:
> This patchset adds support to handle multiple non-identical chips in one
> flash device tree node. It also adds concat support to physmap_of. This
> makes it possible to support e.g. the Intel P30 48F4400 chip which
> internally consists of 2 non-identical NOR chips on one die. Additionally
> partitions now can span over multiple chips:
> 
>     mtd: physmap_of: Add multiple regions and concatenation support
>     mtd/powerpc: Factor out MTD physmap bindings into mtd-physmap.txt
>     mtd/powerpc: Describe multiple "reg" tuples usage
> 
> v2 addresses all comments from Grant Likely, including factoring out the
> MTD dts bindings documentation into a separate file.
> 
> v3 addresses all comments (again from Grant).

Sorry for my ignorance, but could you please explain why regions
exists as an MTD concept? Why different regions could not be
represented as different MTD devices? The benefit is - simplicity.

Thanks.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)
