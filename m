To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS root woes: No init found
References: <200212041635.31861.waite@skycomputers.com>
From: Roland Dreier <roland@topspin.com>
Date: 04 Dec 2002 14:27:46 -0800
In-Reply-To: <200212041635.31861.waite@skycomputers.com>
Message-ID: <52bs41besd.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Brian" == Brian Waite <waite@skycomputers.com> writes:

    Brian> Hi, I am attempting to boot up a custom PPC board and
    Brian> having problems with the NFS Root. the board has a single
    Brian> 74xx PPC and Galileo memory controller. What happens is
    Brian> everything looks good until I attempt to read init from the
    Brian> NFS root. Then I get the message No init found. I have
    Brian> tried the obvious things such as changing init for a
    Brian> staticly linked executable, to no avail. I have enabled NFS
    Brian> debug and it looks like I have mounted the remote fs just
    Brian> fine.

One thing that sometimes helps in debugging these problems is to use
an ethernet sniffer to see what your target is really getting from the
NFS server.  You can use something like "tcpdump -vvv -s 1500", or
something fancier like ethereal.  Then you can see whether the target
ever even tries to read the init file, etc.

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
