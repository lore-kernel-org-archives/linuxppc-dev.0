Return-Path: <wg@grandegger.com>
Message-ID: <48D0CB3C.7050708@grandegger.com>
Date: Wed, 17 Sep 2008 11:17:48 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: UCC GETH does not work on my MPC8360EA 
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I have a wired problems with my MPC8360EA using Linux 2.6.27-rc6. The
UCC GEHT controller works fine with 100/Full but fails with 1000/Full.
What I see is that the TX done interrupts come (ifconfig's TX packet
counter goes up), but the messages does not show up on the wire. RX
seems to work properly, though.

Any idea what's going wrong? Does someone got it working with 1000/Full?

TIA,

Wolfgang.
