Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF4jd5nZJzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 16:12:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 Borislav Petkov <bp@alien8.de>
Cc: "linux-edac\@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa\@gmail.com" <morbidrsa@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC: mpc85xx: Add T2080 l2-cache support
In-Reply-To: <de8ec9087f214f2fae67b8ea9be92cdc@svr-chch-ex1.atlnz.lc>
References: <20170201231624.28843-1-chris.packham@alliedtelesis.co.nz>
 <20170201232735.byk7bnpeoqtcc7mh@pd.tnic>
 <01fe1af463c640a8bd48e45c2752b52c@svr-chch-ex1.atlnz.lc>
 <20170202173005.gqesvy5owtsbrviu@pd.tnic>
 <87h94cb11m.fsf@concordia.ellerman.id.au>
 <de8ec9087f214f2fae67b8ea9be92cdc@svr-chch-ex1.atlnz.lc>
Date: Fri, 03 Feb 2017 16:12:05 +1100
Message-ID: <874m0bc0yi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:

> On 03/02/17 12:55, Michael Ellerman wrote:
>> Chris if you want to send a patch to add the compatible string to the
>> l2cache.txt I would merge that, but honestly it doesn't achieve much
>> other than possibly catching a typo in the compatible name.
>
> I think catching a typo might be worthwhile. It's 5 minutes work for me 
> to grep/sed through the code to find existing compatible strings and 
> update the document. Which might save someone else a lot of time 
> debugging only to find out they've transposed some digits in the dts.
>
> I'll whip something up and send it out shortly.

Thanks.

cheers
