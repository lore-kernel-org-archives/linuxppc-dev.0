Return-Path: <erikd@mega-nerd.com>
Received: from hendrix.mega-nerd.net (hendrix.mega-nerd.net [203.206.230.162])
 by ozlabs.org (Postfix) with ESMTP id 341792C02CD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 09:10:15 +1000 (EST)
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
 by hendrix.mega-nerd.net (Postfix) with SMTP id 7FE7F106E72
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 09:01:05 +1000 (EST)
Date: Mon, 10 Jun 2013 09:01:05 +1000
From: Erik de Castro Lopo <erikd@mega-nerd.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: PowerPC assembler question
Message-Id: <20130610090105.fc7ec3f67d0f55cea97283e0@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I'm trying to fix a problem in the PowerPC backend of the Glasgow
Haskell Compiler (GHC) and have a problem with the following
instruction form:

    lwz     30, .label - (1b)(31)

Reading the documentation I could find, I have figured out that this
loads a 16 bit value into register 30. How it calculates that 16 bit
value has got me somewhat flumoxed.

Anybody care to explain?

Cheers,
Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
