From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-fbdev-devel@lists.sourceforge.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: gpm selection vs VGA console & fbcon
Date: Mon, 9 Jul 2001 17:09:24 +0200
Message-Id: <20010709150924.21124@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There's an endian bug that have been around for some time causing
text & attributes to be flipped when doing selections with gpm
in console mode with VGA console enabled & running on an fbdev.

I didn't follow that closely, but since it's popping up again for
users I beleive a fix was never merged in the main tree. Is there
such a patch available or it's still on the list of "things to
look into one day"  ?

;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
