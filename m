Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7E8731007D4
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 07:25:03 +1100 (EST)
Subject: Re: [RFC][PATCH 28/30] powerpc/85xx: Rework P1023RDS device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111110185559.GA12339@schlenkerla.am.freescale.net>
Date: Thu, 10 Nov 2011 14:24:56 -0600
Message-Id: <87FDDAD0-DD3E-4DC2-94F8-917FC2C9FE16@kernel.crashing.org>
References: <1320941653-29797-20-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-21-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-22-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-23-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-24-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-25-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-26-git-send-email-galak@kernel.crashing.org>
 <B48BB824-D8FF-4D60-B0A5-B6C237074907@kernel.crashing.org>
 <20111110185559.GA12339@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 10, 2011, at 12:55 PM, Scott Wood wrote:

> On Thu, Nov 10, 2011 at 12:42:54PM -0600, Kumar Gala wrote:
>>=20
>> On Nov 10, 2011, at 12:10 PM, Scott Wood wrote:
>>=20
>>> On Thu, Nov 10, 2011 at 10:14:11AM -0600, Kumar Gala wrote:
>>>> -		power@e0070{
>>>> -			compatible =3D "fsl,mpc8536-pmc", =
"fsl,mpc8548-pmc",
>>>> -			             "fsl,p1022-pmc";
>>>> -			reg =3D <0xe0070 0x20>;
>>>> -			etsec1_clk: soc-clk@B0{
>>>> -				fsl,pmcdr-mask =3D <0x00000080>;
>>>> -			};
>>>> -			etsec2_clk: soc-clk@B1{
>>>> -				fsl,pmcdr-mask =3D <0x00000040>;
>>>> -			};
>>>> -			etsec3_clk: soc-clk@B2{
>>>> -				fsl,pmcdr-mask =3D <0x00000020>;
>>>> -			};
>>>> -		};
>>>=20
>>> The compatibles on this node are wrong, but it looks like you're =
removing
>>> it altogether?
>>>=20
>>> -Scott
>>=20
>> Yeah, I think the whole thing needs to be relocated at because there =
are no etsec's on P1023, etc.  So will comment about this in commit =
message
>=20
> Ah right, the etsec stuff should go as well. :-)
>=20
> It should look like this:
>=20
> 	power@e0070 {
> 		compatible =3D "fsl,p1023-pmc", "fsl,mpc8548-pmc";
> 		reg =3D <0xe0070 0x20>;
> 	};

What does being compatible with mpc8548-pmc mean?

- k=
