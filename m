To: linuxppc-dev@lists.linuxppc.org
Subject: Xpmac
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 21 Oct 1999 15:31:08 +0200
Message-ID: <87904wrgbn.fsf@hades.nocrew.net>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Why does Xpmac set my vc's to 128x48 chars, when I'm using VGA8x8 and
therefor have 128x96 chars on them?

128x48 is normal for 1024x768 with an 8x16 font, but Xpmac seems to
assume that 8x16 is what's being used.

Are there any parameters for this?

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
