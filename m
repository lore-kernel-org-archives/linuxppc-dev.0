Subject: Re: linuxppc-embedded: main kernel tree
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 27 Jan 2000 11:58:54 +1100 (EST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <00012611055301.05597@alan.corp.packetengines.com> from "Alan Mimms" at Jan 26, 2000 11:00:46 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000127005854.B85911B172@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Mimms writes:
> In fact, I'm very interested in the new cramfs I have read about as a
> solution for our flash based file system.

cramfs sure looks interesting as an alternative to an initrd uncompressed
ramdisk or romfs.

A question for the knowledgeable about memory usage efficiency of Linux's
regular ramdisk though: does the kernel share read-only program text space
directly with the binary image data in the ramdisk, or does it copy the data
from the ramdisk when it execs a program?

Thanks,
Graham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
