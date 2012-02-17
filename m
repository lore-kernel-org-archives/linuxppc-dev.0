Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 31B49B70CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 14:18:52 +1100 (EST)
Message-ID: <1329448724.2892.43.camel@pasglop>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-R58472 <r58472@freescale.com>
Date: Fri, 17 Feb 2012 14:18:44 +1100
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F0574273C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <1329439216.2892.36.camel@pasglop>
 <94F013E7935FF44C83EBE7784D62AD3F0574273C@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 03:09 +0000, Li Yang-R58472 wrote:
> >I tried a debian install on the p5020ds here and I find SATA to be
> >extremely slow, generating millions of interrupts. I think the
> defaults
> >should be a lot more aggressive at coalescing.
> 
> The P5020 has a hardware problem with SATA, making it generate more
> interrupts than it should.  A new revision of the silicon will fix it.

Ok cool. With a bit of luck you guys can send me a new silicon when it's
available then :-) (The one in the board you got me seems to be in a
socket).

Cheers,
Ben.
