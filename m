Date: Tue, 28 Sep 1999 18:02:55 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: mlan@cpu.lu, rrschulz@cris.com, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
In-Reply-To: <37F0E59F.ACDBF6CE@chpc.utah.edu>
Message-ID: <Pine.GSO.4.10.9909281801350.11108-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Sep 1999, Lou Langholtz wrote:
>   1. First my IP connections over PPP get slower and slower. I have a
>      28.8Kbaud modem and ussually connect at 21Kbaud and get about that in
>      transfer rate. After a couple days of packets my transfer rates get
>      worse and worse. I start seeing 38 byte per second transfers and then a
>      few hours later the connection just seizes up all-together. I have a
>      Cisco 2511 at the other end and suspect it has something to do with the
>      problem. At least in encouraging it.
>   2. Then I reconnect my modem via netcfg de-activating PPP and
>      power-cycling my modem. For a while again I get reasonable transfer
>      rates. But then the same thing happens again where the rate drops
>      abysmally.
>   3. Finally, after a few connection lock / PPP reconnect cycles, the next
>      lock-up is my whole machine. Sometimes, after the reboot, connecting to
>      the same places I hang my whole machine again right away. The longer
>      I wait before connecting to those places however the less I've noticed
>      that it locks right back up again. That leads me to believe that the
>      lock up problem is going on at the TCP layer; not at the PPP layer. Of
>      course if it didn't have anything to do with the PPP layer then people
>      not using PPP would see this problem as well.

I see similar things with Ethernet (de4x5), including the lock up when trying
to ifconfig the interface down.

A similar bug was just fixed in the 2.2.x branch of vger. I asked Dave Miller
whether the same bug is also present in 2.3.x, and he said no.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
