Message-ID: <3C08ADE6.8030004@waitaki.otago.ac.nz>
Date: Sat, 01 Dec 2001 23:16:06 +1300
From: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Byte order in sound drivers
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It seems that some of the newwer media player applications (including
mplayer and the latest xmms from CVS) swap the byte order of sound
samples before playing them on PPC, and this results in nothing but
static from both the dmasound and usb audio drivers.

Is this because the sound driver perhaps already doing endian-swapping,
and can I disable it? Are these applications correct to want to convert
samples into the native endian-ness?

I'm using a 2.4.14 benh kernel.

cheers

Bryce.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
