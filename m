Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 53D92DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 01:10:01 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2292293wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 08:10:00 -0700 (PDT)
Message-ID: <fa686aa40708280810v48d294h87779374e6a7038d@mail.gmail.com>
Date: Tue, 28 Aug 2007 09:10:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0708281642520.4960-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708280650t41046711g4161cc0c5be05d16@mail.gmail.com>
	<Pine.LNX.4.44.0708281642520.4960-100000@slslc02.psi.ch>
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> 8. I have typed: md 0x20f0c4 100 and it showed me the buffer:
>
> 0020f0c4: 3c353e5b 20202020 302e3030 30303030    <5>[    0.000000
> 0020f0d4: 5d204c69 6e757820 76657273 696f6e20    ] Linux version
> 0020f0e4: 322e362e 32312d72 63362028 726f6f74    2.6.21-rc6 (root
> 0020f0f4: 40706335 32313529 20286763 63207665    @pc5215) (gcc ve
> 0020f104: 7273696f 6e20342e 302e3229 20233136    rsion 4.0.2) #16
> 0020f114: 204d6f6e 20417567 20323720 31323a33     Mon Aug 27 12:3
> 0020f124: 373a3038 20434553 54203230 30370a3c    7:08 CEST 2007.<
> 0020f134: 363e5b20 20202030 2e303030 3030305d    6>[    0.000000]
> 0020f144: 2058696c 696e7820 4d4c3430 33205265     Xilinx ML403 Re
> 0020f154: 66657265 6e636520 53797374 656d2028    ference System (
> 0020f164: 56697274 65782d34 20465829 0a3c373e    Virtex-4 FX).<7>
> 0020f174: 5b202020 20302e30 30303030 305d2045    [    0.000000] E
> 0020f184: 6e746572 696e6720 6164645f 61637469    ntering add_acti
> 0020f194: 76655f72 616e6765 28302c20 302c2038    ve_range(0, 0, 8
> 0020f1a4: 31393129 20302065 6e747269 6573206f    191) 0 entries o
> 0020f1b4: 66203235 36207573 65640a3c 343e5b20    f 256 used.<4>[
> 0020f1c4: 20202030 2e303030 3030305d 205a6f6e       0.000000] Zon
> 0020f1d4: 65205046 4e207261 6e676573 3a0a3c34    e PFN ranges:.<4
>
> So it seams to be that the address points to the __log_buf (I hope).
>
> Does it mean that when I try to start zImage kernel from u-boot
> it hangs during uncompressing the image and it does even start booting?

Think about what you're looking at.  That buffer is ASCII text.  Does
it look like the entire buffer is displayed, or does it look like
there is more?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
