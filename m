From: "Rob Taylor" <robt@flyingpig.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: kernel executing from flash
Date: Mon, 27 Mar 2000 09:54:46 +0100
Message-ID: <000001bf97ca$1a27d7f0$b400a8c0@eventhorizon>
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
In-reply-to: <200003241749.MAA00739@misery.wavemark.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> For our (non-linux) embedded systems, if we're going to run from
> flash, we store the executable in flash uncompressed.  Price is an
> issue which favors RAM, but speed issues no longer favor RAM - the new
> intel burst flash is faster than RAM in one of our systems.

isn't it only faster for burst reads tho? that sort of speed increase
doesn't really help when running code..

Rob


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
