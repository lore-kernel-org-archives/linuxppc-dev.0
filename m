Date: Mon, 6 Sep 1999 15:37:50 +0200 (MET DST)
From: Geert Uytterhoeven <geert@sonycom.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
cc: linux-mac68k@mac.linux-m68k.org
Subject: Re: mac-2.3.14.diff: adb
In-Reply-To: <v03130308b3ec440550d3@[192.168.1.1]>
Message-ID: <Pine.GSO.4.10.9909061533460.554-100000@oleander.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I'd also like to see a global CONFIG_ADB option. At the moment the kernel
doesn't link if you don't set CONFIG_MAC_KEYBOARD due to numerous references to
ADB stuff. I fixed it `quick' by always linking in drivers/macintosh/adb.o.

Is it OK to protect all ADB references with #ifdef CONFIG_ADB/#endif?

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- SONY Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Tel +32-2-7248608 Fax +32-2-7242686 ------------------ B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
