Message-ID: <3A8D40BB.F031465D@opensource.se>
Date: Fri, 16 Feb 2001 16:01:15 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Runtime libs
References: <3A8C6C98.6E5C3889@intel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



> Now I'm looking for a runtime lib. I've tried compiling both stock
> glibc-2.2.1
> and dietlibc, and failed miserably. What is the favored runtime lib now
> for
> a 823 target?

I've used glibc-2.1.3 with some patches for my mpc8xx projects.
You will need a patch for the cacheline size, (search this list)
and a patch to fix a typo affecting little-endian in C-ctype.c.

I cross-compile it on a x86-box and it works like a dream. =)

A good thing to do is to download tarballs+diffs/SRPMS from
debian/redhat
and check out their patches.

Hope this helps /

Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
