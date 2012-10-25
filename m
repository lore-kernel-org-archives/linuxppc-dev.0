Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 991EE2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 19:47:14 +1100 (EST)
Message-ID: <1351154804.2728.166.camel@pasglop>
Subject: Re: iMac (PM61) quieter fan?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Elgin <jeremy@jeremyelgin.me>
Date: Thu, 25 Oct 2012 19:46:44 +1100
In-Reply-To: <26F74A8F-8BCD-4E97-99F4-8DF14C2568D6@jeremyelgin.me>
References: <26F74A8F-8BCD-4E97-99F4-8DF14C2568D6@jeremyelgin.me>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-10-25 at 16:13 +1300, Jeremy Elgin wrote:
> I'm running Ubuntu 12.04 on my iMac G4 1GHz (PowerMac6,1) and I've
> been looking for any installable option to quiet the fan, nothing I've
> found mentions PowerMac6,1 and the modules installed don't even
> mention different PM models, just therm_windtunnel.ko &
> windfarm_core.ko - this first module won't load (No such device) and
> the second isn't used by anything (yet), do I need to install a .deb
> package that'll talk to this module?
> 
> I know this is not really about development but it's specific to PPC,
> ok? :-)

I don't know much about the fan control on the iMac G4. You can try
sending me a dump of /proc/device-tree (a tarball), it might tell us
more about what's in there.

> Oh, I also have a Dual 2.0 GHz G5 (PowerMac7,3) that I'm keen to get
> Ubuntu running on as a headless server and it'll need fan controls
> too. What I mean to say is, I'm keen to help out with these two pieces
> of hardware should you need testers for them specifically.

This should be fully supported already.

Cheers,
Ben.

> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
