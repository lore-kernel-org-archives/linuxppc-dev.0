Message-Id: <200205250114.g4P1ELi08721@panix1.panix.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: P2P bridge (DEC 21154) initialization on MCP750
From: Rajappa Iyer <rsi@panix.com>
Date: 24 May 2002 21:14:21 -0400
Reply-To: rsi@panix.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having problems with the PCI-PCI bridge (DEC 21154) on the MCP750
and would appreciate any words of wisdom.  Basically, this bridge does
not get initialized and therefore no devices are probed on the
secondary bus.

I've tried all three kernel trees from source.mvista.com
(linuxppc_2_4, linuxppc_2_4_devel and linuxppc_2_5).  The devel branch
does not get past the Bogomips calibration loop.  The other two do not
initialize the bridge.

Any ideas on how to fix this?

Thanks,
Rajappa
--
<rsi@panix.com> a.k.a. Rajappa Iyer.
	They also surf who stand in the waves.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
