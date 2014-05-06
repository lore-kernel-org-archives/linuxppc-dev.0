Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by ozlabs.org (Postfix) with ESMTP id 8C085140305
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 17:48:10 +1000 (EST)
In-Reply-To: <5368811A.3060609@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-5-git-send-email-Shruti@Freescale.com>
 <1398118442.1694.190.camel__272.432543761347$1398129129$gmane$org@snotra.buserror.net>
 <53661DAB.10808@Freescale.com>
 <1399332886.15726.161.camel@snotra.buserror.net>
 <5368811A.3060609@Freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] powerpc/corenet: Add DPAA FMan support to the SoC
 device tree(s)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF3FF1D0D1.9BC865BB-ONC1257CD0.0029D93B-C1257CD0.002A330F@transmode.se>
Date: Tue, 6 May 2014 09:40:55 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@Freescale.com>, devicetree@vger.kernel.org,
 Kanetkar Shruti-B44454 <Shruti@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Linuxppc-dev" 
<linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org> 
wrote on 2014/05/06 08:28:42:
> 

.....

> 
> > That said,
> > I don't object to having a way to label a PHY as attached via TBI if
> > that's useful.  I'm giving a mild, non-nacking (given the history)
> > objection to using device_type for that (given other history).
> 
> Personally, I think that TBI PHY support is a bit messy but I don't have
> bandwidth to deal with that. The TBI PHY should be handled as a regular
> PHY and right now is a special case

Yes please! We will use the TBI as the only PHY in 1000BASE-X mode so
naturally we want to see the TBI as its own PHY and monitor its link 
status, AN etc.

 Jocke
