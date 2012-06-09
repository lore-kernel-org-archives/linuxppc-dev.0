Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A4037B6FC2
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2012 19:00:55 +1000 (EST)
In-Reply-To: <4FD25146.5090108@freescale.com>
References: <OF71CEA252.1CE143D5-ONC1257A17.00329573-C1257A17.003D00D0@transmode.se>
 <4FD25146.5090108@freescale.com>
Subject: Re: P2010 External HW IRQ number?
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFA31422D6.CC72BDBF-ONC1257A18.0031549A-C1257A18.003183C0@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 9 Jun 2012 11:00:49 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Scott Wood <scottwood@freescale.com> wrote on 2012/06/08 21:23:50:

> From: Scott Wood <scottwood@freescale.com>
> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
> Cc: <linuxppc-dev@ozlabs.org>
> Date: 2012/06/08 21:25
> Subject: Re: P2010 External HW IRQ number?
>
> On 06/08/2012 06:06 AM, Joakim Tjernlund wrote:
> >
> > I have been trying to figure out what irq number to use for external IRQs for
> > the P2010. There are no HW IRQ numbers in the ref manual and I cannot find
> > any examples in the kernel either.
> > How do specify irq numbers in my dts for external IRQs?
>
> See Documentation/devicetree/bindings/powerpc/fsl/mpic.txt

Ahh, now I see. however I must say that I didn't until I read this older version first:
 http://os1a.cs.columbia.edu/lxr/source/Documentation/powerpc/dts-bindings/fsl/mpic.txt?a=x86;v=2.6.34

 Jocke
