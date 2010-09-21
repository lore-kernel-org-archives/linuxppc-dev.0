Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 6BA63B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 17:30:19 +1000 (EST)
Message-ID: <4C985F02.7060403@c-s.fr>
Date: Tue, 21 Sep 2010 09:30:10 +0200
From: LEROY Christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org
Subject: Dual ethernet attachment with single FEC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I have a board with 2 PHYs attached to one FEC ethernet controler on 
powerpc.
I want to implement some kind of main-standby attachment to LAN by 
setting the ISOLATE bit on one on the two PHYs then monitoring the link 
status and switch to the other PHY when the link status goes down.

I see this behaviour is implemented in the sis900 driver, but it doesn't 
use the standard PHY layer as the Freescale FEC driver does.

What would be the most proper way to implement this functionality ?
* Modify FEC driver to manage that ?
* Implement a virtual PHY driver that would manage that ?
* Other solution ?

Best regards
C. Leroy
