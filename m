From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: compile bug/fix, 2.4.19pre3
Date: Tue, 19 Mar 2002 19:40:42 +0100
Message-Id: <20020319184042.17574@smtp.wanadoo.fr>
In-Reply-To: <p0510030bb8bd42311546@[66.26.75.241]>
References: <p0510030bb8bd42311546@[66.26.75.241]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Compiling today-rsynced 2.4.19pre3 (source.mvista.com::linuxppc_2_4) yields:
>
>drivers/net/net.o: In function `bmac_set_multicast':
>drivers/net/net.o(.text+0xa5e0): undefined reference to `ether_crc_le'
>drivers/net/net.o(.text+0xa5e0): relocation truncated to fit:
>R_PPC_REL24 ether_crc_le
>make: *** [vmlinux] Error 1
>

Fix already pushed, wait for mirrors to react.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
