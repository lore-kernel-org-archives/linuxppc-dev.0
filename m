Date: Fri, 12 May 2000 15:15:24 +0000 (GMT)
From: Shiloh Heurich <shiloh@comtechmobile.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: ROCK Linux -- Any success?
Message-ID: <Pine.HPX.4.21.0005121514310.2393-100000@duckboy.comtechmobile.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was just wondering if anyone has successfully built the current
(v1.3.9) ROCK Linux distribution?  I haven't gotten past the setup process
yet -- my problem revolves around getting the devfs filesystem to work on
my current system in preparation for the build.  If I compile a 2.3.99
kernel with devfs support, my machine (G4/450) will boot, but I get
intermittent kernel panics during compilation of the ROCK sources.  If,
instead, I compile a 2.2.15pre20 kernel with devfs support (after applying
the devfs patch for this kernel version), my machine boots most of the
way, but doesn't seem to recognize the new /dev layout, and therefore will
not mount any of the filesystems (including /).  So, without spending too
much time trying to get either of these approaches to work, I'd be
interested to know if anyone has successfully built and installed ROCK.

Shiloh Heurich

--
Shiloh Heurich
Software Engineer
Comtech Mobile Datacom Corporation


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
