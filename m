Message-Id: <s8877a79.049@mail.frequentis.com>
Date: Thu, 20 Jan 2000 21:13:10 +0100
From: "Ralf HECKHAUSEN" <RHeckhau@frequentis.com>
To: "<"<linuxppc-embedded@lists.linuxppc.org>
Cc: <dan@netx4.com>
Subject: Re: Embedded planet 860T CLLF HELP!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I just placed the latest MPC860T FEC driver on ppc.kernel.org.
>This seems to work with the Embedded Planet CLLF.  It is a
>pretty bad hack, as the driver should really determine many
>of the things in #ifdef's dynamically.
>
>Another thing.  On the "back" side of the CLLF, at the edge
>near the four switch pack, you will find an unpopulated R08.
>Place a jumper wire across this, as it is the source of the
>PHY link change interrupt to the Port C pin.  Future CLLF boards
>will have this populated.
>
>And another thing.  This driver doesn't seem to work correctly
>on the 860P version of the boards.  I thought I found all 860P
>differences, but I guess I missed something.  I am working on it,
>and if you have one of these boards, please let me know.

Try to initialize PDDIR with 0x1fff instead of 0x1c58.

>	-- Dan

Ralf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
