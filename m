Date: Wed, 3 May 2000 14:47:15 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Scott Knight <scott@re-104-1.read.indiana.edu>
cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: hfs
In-Reply-To: <Pine.LNX.4.10.10005031624170.3553-100000@fletch.read.indiana.edu>
Message-ID: <Pine.LNX.3.96.1000503144435.24757O-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 3 May 2000, Scott Knight wrote:

> Ok heres a quick question to that followup. Even if this group gets HFS+
> working that doesnt mean normal HFS will be working right? I personally
> dont have any drives HFS+ formatted and dont plan on making any of them
> that way. So even if HFS+ works that really doesnt help people wanting to
> use HFS. Thanks for all the info.

I'm under the impression that HFS is basically a subset of HFS+, i.e. HFS+
working should fix HFS.  I could easily be wrong, though.  Regardless,
they're probably modifying the HFS code to also support HFS+, which
probably would mean that they'd be fixing the HFS code in the process
(since the problems are more general OS-related, rather than actual
filesystem metadata-specific bugs).  But it's hard to say for sure until
somebody actually gets it working.  ;-)


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
