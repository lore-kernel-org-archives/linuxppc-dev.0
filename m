Message-Id: <199903231631.LAA09001@mail-1.global2000.net>
Date: Tue, 23 Mar 1999 11:31:30 -0500
Subject: RE: HFS+ Support / Quick Question
From: "AArthur" <arthur99@global2000.net>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I was just wondering whether LinuxPPC 5.0, will be able to read and write to
>HFS Plus drives. I have had a look through your sites but could not find any
>info on this.

Nope. Don't count on HFS+ support in the near future, there is more
important things to wait for in life.

It will not be ready for LinuxPPC 5.0, for certain.

HFS+ support is underway, it will probably be at least a year before
reliable HFS+ support will be useable. While the Darwin project is providing
some answers on this, any work currently done is a extremely primitive. Some
estimates say that Linux HFS+ support should be workable in the Summer of
1999, at the earliest.

Anyway, Mac OS 8.x's support of HFS+ is really bad, so I would stay away
from HFS+ for a while. (HFS+ File Manger is emulated under Mac OS 8.x).
That's why you see on MacFixit, that HFS+ benchmarks are slower then HFS
benchmarks.

You can continue to use a HFS disk to transfer data between the Mac OS and
Linux for the mean time.

Thanks,

AArthur
arthur99@global2000.net << Note Domain Change!



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
