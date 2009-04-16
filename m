Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <1239884344.3390.213.camel@localhost.localdomain>
References: <200904161405.04100.sr@denx.de>
	<1239884344.3390.213.camel@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 06:58:22 -0600
Message-ID: <fa686aa40904160558p613f43cbo361a500adee10d34@mail.gmail.com>
Subject: Re: [PATCH 0/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
To: dedekind@infradead.org
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linux-mtd@lists.infradead.org,
	devicetree-discuss <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 6:19 AM, Artem Bityutskiy
<dedekind@infradead.org> wrote:
> On Thu, 2009-04-16 at 14:05 +0200, Stefan Roese wrote:
>> This patchset adds support to handle multiple non-identical chips in one
>> flash device tree node. It also adds concat support to physmap_of. This
>> makes it possible to support e.g. the Intel P30 48F4400 chip which
>> internally consists of 2 non-identical NOR chips on one die. Additionall=
y
>> partitions now can span over multiple chips:
>>
>> =9A =9A mtd: physmap_of: Add multiple regions and concatenation support
>> =9A =9A mtd/powerpc: Factor out MTD physmap bindings into mtd-physmap.tx=
t
>> =9A =9A mtd/powerpc: Describe multiple "reg" tuples usage
>>
>> v2 addresses all comments from Grant Likely, including factoring out the
>> MTD dts bindings documentation into a separate file.
>>
>> v3 addresses all comments (again from Grant).
>
> Sorry for my ignorance, but could you please explain why regions
> exists as an MTD concept? Why different regions could not be
> represented as different MTD devices? The benefit is - simplicity.

Trying to describe MTD partitions that span device boundaries in the
device tree is far simpler if a single node is used.  It is also a
common case for hardware designers to drop down multiple NOR devices
to be used as a single flash region, so it makes sense to describe it
as a single device.

g.

>
> Thanks.
>
> --
> Best regards,
> Artem Bityutskiy (=E2=C9=D4=C0=C3=CB=C9=CA =E1=D2=D4=A3=CD)
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
