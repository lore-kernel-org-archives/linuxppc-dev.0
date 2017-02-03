Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vFBpX2krnzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 20:46:44 +1100 (AEDT)
Date: Fri, 3 Feb 2017 10:46:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC: mpc85xx: Add T2080 l2-cache support
Message-ID: <20170203094618.7m4j6uycaefixekf@pd.tnic>
References: <20170201231624.28843-1-chris.packham@alliedtelesis.co.nz>
 <20170201232735.byk7bnpeoqtcc7mh@pd.tnic>
 <01fe1af463c640a8bd48e45c2752b52c@svr-chch-ex1.atlnz.lc>
 <20170202173005.gqesvy5owtsbrviu@pd.tnic>
 <87h94cb11m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87h94cb11m.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 03, 2017 at 10:55:33AM +1100, Michael Ellerman wrote:
> > So I'd like to have an ACK from a PPC maintainer here first before I
> > apply this.
> 
> It's fine with me:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied,
thanks guys.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
