Return-Path: <oss@buserror.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 681FD1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 11:55:21 +1100 (AEDT)
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 153ED1402BC
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 11:55:20 +1100 (AEDT)
Message-ID: <1452558297.19133.47.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Lakshmi <lucky.veeramallu@gmail.com>, linuxppc-dev@ozlabs.org
Date: Mon, 11 Jan 2016 18:24:57 -0600
In-Reply-To: <loom.20160106T083706-822@post.gmane.org>
References: <loom.20160106T083706-822@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: p4080ds IRQ vector number for he External IRQ4 and IRQ5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-06 at 08:40 +0000, Lakshmi wrote:
> I have been trying to figure out what is the vector number used for external
> IRQ4 and IRQ5 in P4080ds.
> 
> According to board document xpedite5470-p4080 
> IRQ4: VPX GP Input 0 (GPI0)
> IRQ5 VPX GP Input 1 (GPI1)
> 
> In p4080 user guide OpenPIC interrupt connection its mentioned as
> 
> IRQ4_B: SLOT4 Sideband connector (SGMII riser does not connect, XAUI riser
> can use or inband)
> 
> IRQ5_B: MIC2076 USB Power FLAG for over current at USB connector
> 
> But in code i am unable to find any info related to IRQ4 and IRQ5.
> 
> How can i find??

Are you asking what to put in the device tree for these interrupts?  External
IRQ4 is <4 ls 0 0> and IRQ5 is <5 ls 0 0>, with ls being the level/sense info.

See Documentation/devicetree/bindings/powerpc/fsl/mpic.txt for details.

-Scott
