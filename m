Date: Mon, 11 Oct 1999 08:30:03 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michel Lanners <mlan@cpu.lu>
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: busmaster/latency for video
In-Reply-To: <199910081759.TAA00313@piglet.cpu.lu>
Message-ID: <Pine.GSO.4.10.9910110828450.9144-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 8 Oct 1999, Michel Lanners wrote:
> OF itself doesn't enable any memory or IO region; it's the
> device-specific init code (which might be on-board for PCI cards, or in
> OF for motherboard devices).
> 
> There are, however, a few things OF does for _every_ PCI device, among
> which enabling bus mastering and assigning memory and/or IO resources.
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
assigning some memory and/or IO resources? Or is this only the case in the
Longtrail-OF-which-is-better-than-Apple-OF-except-maybe-for-assigning-resources
case?

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
