Date: Mon, 27 Sep 1999 09:07:16 +0200 (MET DST)
From: Geert Uytterhoeven <geert@sonycom.com>
To: Randall R Schulz <rrschulz@cris.com>
cc: mlan@cpu.lu, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
In-Reply-To: <v04210104b4143d523d32@[206.173.234.127]>
Message-ID: <Pine.GSO.4.10.9909270906510.11511-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 26 Sep 1999, Randall R Schulz wrote:
> Yes, I, too, have the hunch that the problem is data sensitive and 
> may relate to checksum generation. There were 17 messages in 
> LinuxPPC-Dev (topic: "TCPv4 checksum errors") late last December 
> about checksum generation problems, but the thread ended and it 
> appeared that either the problem was fixed or was deemed spurious to 
> begin with.

The bug in the checksum routines was fixed (by Petr Vandrovec, IIRC).

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
