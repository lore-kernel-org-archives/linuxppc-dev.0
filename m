From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_ADBMOUSE
Date: Thu, 17 Oct 2002 20:42:54 +0200
Message-Id: <20021017184255.8221@192.168.4.1>
In-Reply-To: <Pine.GSO.4.21.0210171831370.401-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0210171831370.401-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Does Linux/PPC on PowerMac still use the code in drivers/macintosh/mac_keyb.c
>that's protected by CONFIG_ADBMOUSE? It's removed in the m68k tree.
>If no, I'll send a patch to remove it to Linus.

No, we only used adbhid nowadays, at least in 2.5. I'm about to
rework significantly the ADB code anyway to use the new driver
model (define an adb bus type & framework for drivers).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
