Date: Wed, 3 Nov 1999 13:42:12 -0700
From: Cort Dougan <cort@ppc.kernel.org>
To: Andreas <a.tobler@schweiz.ch>
Cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.25 builds
Message-ID: <19991103134212.A28448@chimaera.ppc.kernel.org>
References: <381F63A2.BE4A2AD7@schweiz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <381F63A2.BE4A2AD7@schweiz.ch>; from Andreas on Tue, Nov 02, 1999 at 11:20:22PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The next release should build for PPC.  There were some swap changes that
had to be cleaned up.  The Linus 2.3.x trees are now nearly up-to-date with
my tree so it shouldn't be released with ppc broken as often now.

} Hi all,
} sitting here and try to build a 2.3.25 for PPC. No success. The same
} with 2.3.23/24. 2.3.23 worked except I had horrible amounts of Ram (2GB
} iso 80MB). Was to late to figure out the 2.3.24 the 2.3.25 was already
} out. So I tried this one.
} In the beginning not much luck, got some steps further when applying the
} fbmem patch mentioned on this list the earlier the day. (ramdisk support
} was disabled from beginning).
} Later I struggled about pieces in memory.c; pte is not member of.... Ok,
} I found some hints, but as a newbie I saw that there are too many things
} included. Diff showed me too many things changed. So, Paul, Cort, are
} you already aware of?
} 
} Another major question I have, what is the 'deciding fact' for releasing
} a new dev kernel? Only one or two/three arch's working? I noticed that a
} few people had also problems building 2.3.25. ( Intel camp) Or, is it
} only the number count? (25 is better than 24?)
} Sorry, this is a bit cynic. But on the 2.2.x I see that there are up to
} at least xy pre's before a new Kernel is released.
} 
} This mail is NOT meant as a blame, but I don't know how to treat such
} quick changes on the kernel side. Do I have to wait for a working kernel
} x steps behind the offical kernel?
} Yeah, I know I don't have to, I should contribute .... If I can....
} As said, what is the aim of releasing kernels in such short time stamps?
} 
} Regards & thanks for Linux (I still prefer it to MacOS9)
} 
} Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
