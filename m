Message-Id: <v04003a01b436befa25c7@[216.81.6.11]>
In-Reply-To: <v04210112b436ae4d5107@[192.168.0.1]>
References: <v0313030db436a6abe40d@[17.202.21.235]>
 <3810680B.51E0FABD@iname.com> <3810680B.51E0FABD@iname.com>
 <v0313030db436a6abe40d@[17.202.21.235]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 22 Oct 1999 20:38:43 -0500
To: Ethan Benson <erbenson@alaska.net>, Peter Bierman <bierman@apple.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
From: Tony Mantler <eek@escape.ca>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:24 PM -0500 10/22/99, Ethan Benson wrote:
>On 22/10/99 Peter Bierman wrote:
[...]
>>Standard HFS is a pretty simple filesystem.
>
>not really, otherwise we would have mkfs.hfs and a 2.4 kernel
>compatible hfs.o, its obviously complicated enough that nobody wants
>to spend the time on it. (more to the point its irrelevant how
>complicated it is, nobody is working on it.)

Being a person who knows how HFS works (After having to manually rescue my
main drive. Oops, good lesson to always backup), I can say that it is
indeed a very simple filesystem.

The basic parts of HFS are a Parent Directory/Filename sorted catalog
B-Tree, a Filenumber (iirc) sorted Extents B-Tree, a volume bitmap, and a
few special blocks sprinkled about for good measure.

*However*...

Coding a stable, writable filesystem - *any* filesystem - is a bloody pain
in the wrists, and thus not something people (including myself) tend ot
volunteer to do. As such, it doesn't get done very often. (Though sometimes
money and equipment donations help get things done. *hint* *hint*) :)

Both HFS and HFS+ are completley and accuratley documented at Apple's web
site. Anyone interested in the issue should take the time to read and
understand those documents, it's well worth the effort.


Cheers - Tony


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
