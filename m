Subject: Re: BOOTP problems on Embedded Planet CLLF with Monta Vista kernel
To: PaulFagerburg@RenaissanceNT.com
Date: Fri, 4 Aug 2000 10:22:45 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org ('linuxppc')
In-Reply-To: <000c01bffda4$9a12f220$5301a8c0@RenaissanceNT.com> from "Paul Fagerburg" at Aug 03, 2000 04:43:18 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000804002245.CC901BE@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Fagerburg writes:
> Once I started dhcpd (the DHCP *server*), nothing went right from then
> on; the TFTP client on the CLLF timed out with ARP failures.

Here's my guess: The IP addresses of both your TFTP server and your CLLF board
have to be static, and you must configure both addresses into the CLLF using
"C)onfigure EEROM", "7) Modify parameters..." from the main menu.  While the
kernel will get its IP address dynamically via DHCP, the ROM monitor isn't
smart enough to do so before it launches its TFTP request.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
