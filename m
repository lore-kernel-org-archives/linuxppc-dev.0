Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 04D632C007B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 10:38:14 +1100 (EST)
Message-ID: <1358465885.2782.24.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jan Engelhardt <jengelh@inai.de>
Date: Fri, 18 Jan 2013 10:38:05 +1100
In-Reply-To: <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-17 at 15:38 +0100, Jan Engelhardt wrote:
> 
> Meanwhile, I run Linux 3.7.1 and the software side changed somewhat.
> windfarm_rm31 seems to no longer calm the fans down once loaded,
> whereas therm_pm72 on Linux 3.0 did so.

Hrm, that would be a bug ... unfortunately I never got to test it
properly due to my xserve being dead.

Can you turn on debug in there ?

-#undef DEBUG
-#undef LOTSA_DEBUG
+#define DEBUG
+#define LOTSA_DEBUG

It will be *very* verbose ....

Cheers,
Ben.
