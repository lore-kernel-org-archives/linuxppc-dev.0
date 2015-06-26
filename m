Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC2FC1A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 08:38:59 +1000 (AEST)
Message-ID: <1435358324.26815.17.camel@kernel.crashing.org>
Subject: Re: pSeries boot failure due to wrong interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Linton <jlinton@tributary.com>
Cc: Rob Herring <robherring2@gmail.com>, Jeremy Linton
 <lintonrjeremy@gmail.com>, Grant Likely <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 27 Jun 2015 08:38:44 +1000
In-Reply-To: <558DD3C8.6000800@tributary.com>
References: <CAEFTgiyHkf8ooYdWW0nTLcdraJ_L9FpLSVZa4KS3CcdpGWJxew@mail.gmail.com>
 <CAL_JsqJqkUL8XyqR6yjg+-thj4YOQ6cUohGHHid71tdRFft7vw@mail.gmail.com>
 <558D91C1.6030004@tributary.com>
 <1435355687.26815.8.camel@kernel.crashing.org>
 <558DD3C8.6000800@tributary.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-06-26 at 17:35 -0500, Jeremy Linton wrote:
> On 6/26/2015 4:54 PM, Benjamin Herrenschmidt wrote:
> > Ah I missed that completely. From your discussion, it looks correct, I'll
> > see if I can find a machine to test, however I think we dropped support for
> > POWER3 so it might be non-trivial to do so.
> 
> 	Thanks, the problem originally cropped up on a power4+, I was going to test
> it on power5 too, but I don't have access anymore. I do have a power3 as well,
> but I think that machine has other issues (the BUG_ON in the platform table
> for starters).

Ok, I don't think I still have one of these, but if you re-send the
patch with S-O-B etc... I'll review & ack it.

Cheers,
Ben.
