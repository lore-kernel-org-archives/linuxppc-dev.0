Date: Thu, 11 Apr 02 10:31:13 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204111731.AA29012@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: The very common kernel, again...
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Why?  Why is it a good thing to put this into 'CONFIG_ALL_PPC' ?  You
> still end up with 3 images (PReP, vmlinux for pmac/chrp, PPCStar) which
> I wouldn't think is any worse from N (either the FW lets you load an
> abitrary kernel off of the CD/HD/whatever, or you have to put on the
> !vmlinux (in CONFIG_ALL_PPC's case, yaboot) booting kernel else-where.

But we wouldn't have this mess if you guys would just let us have one
CONFIG_GENERIC_PPC32 vmlinux with a standardized and stable boot ABI. Then we,
the people with incentive to sell boards, would do what we need to do with our
firmware or booters or whatever to boot that standard vmlinux and make it as
easy as possible for people like Debian to support us in the standard dist.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
