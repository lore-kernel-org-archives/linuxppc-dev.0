Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3B7E82C008B
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2012 07:02:13 +1100 (EST)
Message-ID: <1350849666.2476.138.camel@pasglop>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Berger <gmane@reliableembeddedsystems.com>
Date: Mon, 22 Oct 2012 07:01:06 +1100
In-Reply-To: <50841653.4050301@reliableembeddedsystems.com>
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com>
 <1350587006.2476.12.camel__24873.815305955$1350587085$gmane$org@pasglop>
 <50841653.4050301@reliableembeddedsystems.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, mla@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-10-21 at 18:35 +0300, Robert Berger wrote:
> Hi,
> 
> On 10/18/2012 10:03 PM, Benjamin Herrenschmidt wrote:
> > 
> > Which looks correct. So this might be something specific to ELDK ?
> 
> I just tried with the ELDK 5.2.1 and have exactly the same behavior as
> with ELDK 4.2, so I guess there is something not correct in
> arch/powerpc/sysdev/ppc4xx_msi.c.
> 
> Just to exclude the case that I'm doing something stupid which only
> affects kernel versions 3.5+ and not 3.4 can someone else give it a try
> with a kilauea board or something similar?

Remind me what is the symptom ? A specific device isn't working ? Or the
whole kernel goes toast ? My feeling is that those patches make MSIs
work (well that's what they are supposed to do) and for some reason that
doesn't agree with whatever you have connected to the PCIe slot...

Cheers,
Ben.
 
> Regards,
> 
> Robert
> 
> > 
> > Cheers,
> > Ben.
> > 
> 
> ..."Serious programming is systems programming or anything beyond
> writing factorial(n) as a student exercise." -- Brian W. Kernighan
> 
> My public pgp key is available,at:
> http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
