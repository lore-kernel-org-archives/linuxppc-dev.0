Date: Wed, 2 Feb 2000 23:50:17 -0500 (EST)
From: "mgalgoci@redhat.com" <mgalgoci@redhat.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: reading ext2 fs from open firmware
Message-ID: <Pine.LNX.4.10.10002022340490.2256-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

These are not really devel questions as I'm sure these are relatively
well known subjects. I've got a starmax 4000/160, and I want to be able to
do away with the mac os and use open firmware to boot a linux kernel
directly, much the way you set up a sparc to boot silo (there isn't a
pilo in the works, is there?)

I was wondering where I can find some instructions on setting open
firmware up to do this.

Also, I theoratically have 288 mb of edo ram in this machine, and was
wondering if it was at all possible to use all of it. The machine
currently only sees 160mb of ram. Is this some kind of controller hardware
limitation, or is there a paramater I can set to allow all 288mb to be
visible to linux? (I tried mem=288M as a kernel option). Any insight to
this would be appraciated.

Thanks,

--Matt

--
	Mathew J Galgoci <mgalgoci@redhat.com>

pub  1024D/18C242C0 2000-01-29 Matthew J Galgoci <mgalgoci@redhat.com>
     Key fingerprint = 46C1 B1EB 0BE9 E398 7CC3  E788 007D 4FF9 18C2 42C0
sub  1024g/A0170503 2000-01-29


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
