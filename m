From: "Calum Selkirk" <cselkirk@sophix.uklinux.net>
Date: Sat, 2 Dec 2000 03:20:58 +0000
To: linuxppc-dev@lists.linuxppc.org
Subject: quik + atyfb on powebook wallstreet
Message-ID: <20001202032058.A427@sophix.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi ..

I have been trying to get quik booting working on a Powebook wallstreet
using Apples System Disk to patch OF. I have been able to get linux to
boot however I am getting a melting screen once atyfb is initialized.
I know this was a problem from a while back, i've found a number of
URL's / posts on the deb list relating to this, but I seem to recollect
this being discussed on this list and that the issue was fixed. Is that
correct or is quik booting with atyfb still a gray area on the wallstreet?

I've attempted so far with 2.2.18pre17 and pre21

For what it's worth my primary interest for the OF booting was to see
if is would solve the problem with XFree86-4.0.1 detecting the correct
VRAM (4mb present .. but the logs show:  VideoRam: 3 kByte (OFF) )

I've scanned the list archive but found nothing .. any pointers on this
would be appreciated

thanks in advance

calum

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
