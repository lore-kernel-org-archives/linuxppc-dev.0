From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: 860 ATM - channel deactivation
Date: Mon, 9 Sep 2002 16:39:10 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJOELCCIAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I had a look at the sources of mpc860sar. In mpc860sar.c there is the
mpc860sar_undo_activate_channel() function that deactivates a channel (ATM
VCC) and releases the resources.
I'm curious about the fact that the deactivation of the channel by calling
mpc860sar_del_address_mapping() is performed after all the ressources where
released. Shouldn't it all be done exactly the opposite way arround?
In case the order is wrong no one will notice it as long as there's no
traffic arriving while this function is running. And I didn't had any
trouble so far too. But I'm shure it is wrong.

Could anyone check this? (I hope I'm in the right mailing list. :))

Thanks, Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
