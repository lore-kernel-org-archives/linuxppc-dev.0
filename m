Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDyCY5Yz8zDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 11:19:05 +1100 (AEDT)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Michael Ellerman <mpe@ellerman.id.au>, Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa@gmail.com" <morbidrsa@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC: mpc85xx: Add T2080 l2-cache support
Date: Fri, 3 Feb 2017 00:18:56 +0000
Message-ID: <de8ec9087f214f2fae67b8ea9be92cdc@svr-chch-ex1.atlnz.lc>
References: <20170201231624.28843-1-chris.packham@alliedtelesis.co.nz>
 <20170201232735.byk7bnpeoqtcc7mh@pd.tnic>
 <01fe1af463c640a8bd48e45c2752b52c@svr-chch-ex1.atlnz.lc>
 <20170202173005.gqesvy5owtsbrviu@pd.tnic>
 <87h94cb11m.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/17 12:55, Michael Ellerman wrote:=0A=
> Chris if you want to send a patch to add the compatible string to the=0A=
> l2cache.txt I would merge that, but honestly it doesn't achieve much=0A=
> other than possibly catching a typo in the compatible name.=0A=
=0A=
I think catching a typo might be worthwhile. It's 5 minutes work for me =0A=
to grep/sed through the code to find existing compatible strings and =0A=
update the document. Which might save someone else a lot of time =0A=
debugging only to find out they've transposed some digits in the dts.=0A=
=0A=
I'll whip something up and send it out shortly.=0A=
