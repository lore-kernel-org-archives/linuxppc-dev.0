From: "Jason Wohlgemuth" <jsw-embedded@mindspring.com>
To: "Julia Elbert" <jelbert@enerdyne.com>,
        <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Flash File System
Date: Wed, 10 May 2000 07:28:06 -0400
Message-ID: <NCBBKJKKGDLPHKDPAFFMIEHDCEAA.jsw-embedded@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <67505026E29DD311A9AA00508B7315F3195577@EXCHANGE>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia,

You may wish to look at this page:
http://www.linux-mtd.infradead.org/

I believe this is where we were able to find our FTL, basically we have some
spare flash on our board and we point this driver at a chunk of it.  It in
turn makes Linux see it as a raw device which can be formated and mounted.
Also, upon a quick skim of the page it mentions DiskOnChip drivers as well.

Enjoy!

Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Julia
Elbert
Sent: Tuesday, May 09, 2000 9:25 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Flash File System



Hello,
What kind of flash filesystem works with linux pppc? We tried M-Systems
DiskOnChip, but they claim not support source for the power pc.
What do to? Desperate, please help.

Thank you,
J


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
