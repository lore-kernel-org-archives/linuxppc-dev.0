Message-ID: <001401c00152$f1412ba0$020a0a0a@PaoloScaffardi>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8xx: how to allocate memory for framebuffer in a loadable module?
Date: Tue, 8 Aug 2000 18:07:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm developing a framebuffer device for the mpc823 video. I wrote a loadable
module, that initializes the display and registers the new framebuffer.
The only problem is getting a physical contiguos block of memory where to
put the memory buffer. What function should i use to allocate it outside the
kernel? How, inside it?

Thanx,
Paolo Scaffardi.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
