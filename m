Date: Mon, 13 Sep 1999 23:50:18 -0700
From: Hugh Caley <hcaley@loomer.com>
Subject: PCMCIA on Powerbook G3 Series
To: linuxppc-dev@lists.linuxppc.org
Message-id: <37DDF029.25A4839F@loomer.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is it possible yet to use PCMCIA on a PB G3 Series laptop?  I used to have a
Wallstreet, and now I have a Lombard, plus Paul Mackerras' kernel source tree,
and I never got it working on either.  I just installed the latest 3.1
pcmcia-cs, and simply inserting my little Viking smart card adaptor causes a
kernel panic every time, and having it in at boot does the same thing.

This card works fine under MacOS, and also under Linux for x86; it just shows
up as another drive on the desktop (or as another mountable drive).

There is an old patch for the Mac serial driver at:

http://xenu.phys.uit.no/~alvin/linux/pcmcia-serial.patch

but I'm afraid to use something that out of date, and the other text there
seems to imply that a special kernel config is necessary.  Also, it seems
related to Mac serial support and modems, and my card doesn't have anything to
do with either one, as far as I can tell.

Anyone have more up to date information?

Hugh

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
