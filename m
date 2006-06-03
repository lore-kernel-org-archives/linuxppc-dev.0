Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDD7367A5C
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 10:36:16 +1000 (EST)
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <259AC268-6D75-4EEF-962E-BDBC6D76BC02@kernel.crashing.org>
References: <9FCDBA58F226D911B202000BDBAD4673066CF774@zch01exm40.ap.freescale.net>
	<259AC268-6D75-4EEF-962E-BDBC6D76BC02@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 10:36:00 +1000
Message-Id: <1149294960.7972.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre.Bounine@tundra.com, Liu Dave-r63238 <DaveLiu@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-02 at 09:50 -0500, Kumar Gala wrote:
> On Jun 2, 2006, at 3:20 AM, Zang Roy-r61911 wrote:
> 
> >
> >> How much RAM do you have ? Maybe you are running out of
> >> virtual space ?
> >>
> >> Ben.
> >>
> >>
> >
> > 512MBytes
> 
> If I understand things, there is a 16M region for PCI config space.   
> You could look at just doing the ioremap for each chunk when its  
> needed via the low level calls.

PCI config access is called with locks held, it can't ioremap.

Ben.
