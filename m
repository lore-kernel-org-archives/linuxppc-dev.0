Message-Id: <200008292352.AAA19153@hyperion.valhalla.net>
Date: Wed, 30 Aug 2000 00:52:35 +0100
Subject: [PATCH]  xmon cuda support for 2.2.17
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: multipart/mixed;
   boundary="MS_Mac_OE_3050441555_103212_MIME_Part"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> THIS MESSAGE IS IN MIME FORMAT. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--MS_Mac_OE_3050441555_103212_MIME_Part
Content-type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

hi,

here is an quick hack that gets cuda support into xmon for 2.2.17 (Ben's)
although it should work OK on linux-pmac-stable as well.   It should really
be done like 2.4.0 (but I needed it in a hurry).

It also adds a tee to push stuff to the serial port as well as the screen -
so that you can debug using the screen but, if it all goes horribly wrong,
still collect output on a terminal emulator etc.

you need the patched via-cuda.c as well [previous mail] (although only a
small part of that is necessary for xmon support).

ciao,
Iain.
--MS_Mac_OE_3050441555_103212_MIME_Part
Content-type: application/binary; name="xmon-cuda-2-2-17p20b1-a.diff.bz";
 x-mac-creator="3F3F3F3F";
 x-mac-type="3F3F3F3F"
Content-disposition: attachment
Content-Transfer-Encoding: base64

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

--MS_Mac_OE_3050441555_103212_MIME_Part--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
