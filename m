Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 06FC42C0078
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2012 01:35:21 +1000 (EST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
 id 1SumKs-0008Pb-Sm
 for linuxppc-dev@ozlabs.org; Fri, 27 Jul 2012 17:20:14 +0200
Received: from 146.177.65.86.rev.sfr.net ([86.65.177.146])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 17:20:14 +0200
Received: from g.bugniot by 146.177.65.86.rev.sfr.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 17:20:14 +0200
To: linuxppc-dev@ozlabs.org
From: Geoffrey Bugniot <g.bugniot@gmail.com>
Subject: Re: Memory management problems on a custom PPC 8270 board
Date: Fri, 27 Jul 2012 15:14:37 +0000 (UTC)
Message-ID: <loom.20120727T170057-480@post.gmane.org>
References: <loom.20120723T170223-328@post.gmane.org>
 <500D8067.6070805@freescale.com> <loom.20120724T102618-734@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geoffrey Bugniot <g.bugniot <at> gmail.com> writes:

> 
> Scott Wood <scottwood <at> freescale.com> writes:
> 
> Could you have bad memory timings (or bad memory)?  Usually when I see
> things like this, it's because memory is getting corrupted.
> 

OK, I've found the problem and you were right Scott. RAM chip and 60x BUS
were misconfigurated in U-Boot (PBI mode, PSDMR, PSRT, MPTPR etc.).

G.B.
