From: "Manie Steyn" <msteyn@wmux.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: FEC support
Date: Mon, 26 Jun 2000 10:36:53 -0700
Message-ID: <NEBBIKAICMIJKJMMELBFKELBCAAA.msteyn@wmux.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am running the Embedded Planet Classic 860T with Monta Vista's 2.2.13
kernel and have some trouble in getting the FEC interface up and running.

The "link" LED comes on but after using ifconfig to assign an IP, I get
"neighour table overflow" when pinging to or from the device.

I saw the following mail from Dan regarding the 2.4 tree:

> >>> "dan@netx4.com" 06/08/00 20:56 >>>

> I merged a ton of changes into the FEC driver from Magnus, Graham,
> and myself for generic PHY support.  Don't even think about complaining
> that this doesn't yet work.  I know it doesn't.

Does this also hold for the FEC driver in the 2.2.13 port, or am I doing
something wrong?

Regards
Manie Steyn


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
