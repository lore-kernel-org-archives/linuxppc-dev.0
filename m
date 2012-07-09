Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3ABD42C01B4
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2012 05:44:14 +1000 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
 by gw1.transmode.se (Postfix) with ESMTP id 478FF25884A
 for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2012 21:44:09 +0200 (CEST)
Subject: PCIE Hotplug on P2010(mpc85xx) ?
To: linuxppc-dev@ozlabs.org
Message-ID: <OF18324FBA.9272A499-ONC1257A36.006C006E-C1257A36.006C6943@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 9 Jul 2012 21:44:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Trying to get the pciehp module to work on the above system.
I can see it register but then nothing happens. I suspect there is
something missing that I don't see ATM. Any clues what to look for?

 Jocke
