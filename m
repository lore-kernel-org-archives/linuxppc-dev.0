Date: Tue, 29 Aug 2000 20:16:33 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: "Halfmann, Klaus" <khalfmann@libra.de>
cc: "'Matthew Wilcox'" <matthew@wil.cx>, Roman Zippel <roman@augan.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of HFS+ support (was hfs support for blocksize != 512)
In-Reply-To: <F14441D40E5AD3118886005004607AD10BDD7F@MAIL1>
Message-ID: <Pine.GSO.4.10.10008292004090.22419-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Im currently working on HFS+ support. Im assisted by Brad Boyer
> (flar@pants.edu) . I currently target a remake of the hfsutils
> originally created by rob@mars.org.

Great to hear. :-)

> On the other hand: The hfs acces is normally not needed for heavy
> concurrent acces. (Mhh, there might be AFP Servers publishing HFS
> partions) For now it should be enough to have a global update
> lock on the root of the node. Im not firm with kernel code yet, dont
> ask me about the details :-)

Usermode and kernelmode implementation are two quite different things. I
know that from affs. Lots of things you can easily do in user space are
hard to do in the kernel, e.g. you have no virtual memory (so you to take
care not to waste too much memory), you are limited to page (cache) size
and of course all the possible, funny races in the kernel...

BTW do you plan a hfsck? I started more a hfsdump to better see and
understand the fs structure, that could be extended with consistency
checks and maybe later with repair functionality...

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
