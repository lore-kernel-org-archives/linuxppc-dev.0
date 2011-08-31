Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08E3EB6FA5
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 13:05:47 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E5DA412.5020300@freescale.com>
Date: Tue, 30 Aug 2011 22:05:43 -0500
Message-Id: <54E184ED-3934-4872-B821-ED394C351788@kernel.crashing.org>
References: <1314644999-16955-1-git-send-email-timur@freescale.com>
	<3F34FBCD-3F0B-4D59-A947-C16CC812B42E@freescale.com>
	<4E5DA1CC.1020808@freescale.com>
	<DBF3606B-8F59-4E5F-9B47-C3E0235665C4@freescale.com>
	<4E5DA412.5020300@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 30, 2011, at 10:01 PM, Tabi Timur-B04825 wrote:

> Kumar Gala wrote:
>>=20
>> On Aug 30, 2011, at 9:51 PM, Tabi Timur-B04825 wrote:
>>=20
>>> Kumar Gala wrote:
>>>> Do we really want the generic "fsl,fpga-cpld"&   "fsl,fpga-pixis"?  =
This seems to vague.
>>>=20
>>> Yes, the PIXIS is generally register compatible across all boards.  =
There
>>> may be some minor differences, but the OCM driver can work with all =
PIXIS
>>> boards that have an PIXIS.
>>=20
>> Is this true?  Don't we have pixis and ngpixis in u-boot?
>=20
> I forgot about that.  Well, everything I said is true about the =
ngpixis,=20
> so I guess I should use "ngpixis" instead of just "pixis" here.  I'll =
have=20
> to check if the old pixis can be used this way.
>=20
>>=20
>>>> Also you need "pixis" on MPC8544DS, MPC8572DS, MPC8536DS.
>>>=20
>>> Ok.
>>>=20
>>>> Also fpga-cpld makes no sense if we keep this.  You are either a =
CPLD or FPGA not both.
>>>=20
>>> Then I don't understand what the CPLD is.
>>=20
>> http://en.wikipedia.org/wiki/Complex_programmable_logic_device
>=20
> Ok, I get it now.  Is there a name for the CPLD we use on these chips?=20=

> I'm having a hard time getting proper documentation on the CPLD.  York=20=

> expressed similar frustration.
>=20
> Perhaps these should be called board-control devices.  How about
>=20
> 	fsl,boardcontrol-cpld
> 	fsl,boardcontrol-ngpixis
> 	fsl,boardcontrol-qixis

For the CPLD based boards I think:

<BOARDNAME>-cpld is best as there isn't really much consistent right =
now.

- k=
