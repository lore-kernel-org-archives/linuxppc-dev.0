Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 29083DE0B3
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 04:22:22 +1100 (EST)
Subject: ucc_geth 10 Mbit/s locks up CPU even though NAPI is enabled
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 18:22:19 +0100
Message-Id: <1196961739.937.17.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Injecting a 10 MBit/s stream with 64 bytes pkgs locks up my
MPC832x CPU even though I got NAPI enabled. Kernel 2.6.23

Any ideas?

 Jocke
