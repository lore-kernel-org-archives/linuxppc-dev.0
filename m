Date: Tue, 20 Apr 1999 19:47:36 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "David A. Gatwood" <marsmail@globegate.utm.edu>
cc: root <roboj@ibm.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.2.6-ac1 problem
In-Reply-To: <Pine.LNX.3.96.990420102601.23151G-100000@globegate.utm.edu>
Message-ID: <Pine.LNX.4.10.9904201946220.31451-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, David A. Gatwood wrote:
> On Mon, 19 Apr 1999, root wrote:
> > I compiled the latest kernel from source and I created vmlinux with no
> > problems.  After installing it in my system folder on my mac partition
> > and booting linux again, I get I/O errors somewhat randomly.
> > The message that is displayed is "No space left on device".  The file
> > /var/log/messages conatins the following lines:
> > 
> > Apr 19 23:23:07 localhost kernel: EXT2-fs error (device ide0(3,4)):
> > ext2_new_block: Free blocks count corrupted for block group 13
> 
> We've had similar problems with free block corruption under MkLinux
> (2.0.37).  This may be a red herring, but I've only noticed the damage on
> the last partition mounted.  You might try mounting a bogus partition
> after the others and see if it goes away.  Just a wild thought.  Anyway,
> the problem began when someone ported some changes from the current
> development sources into the 2.0.xx tree, between 2.0.33 and 2.0.36 (the
> former was fine, the latter has the problem.  It might be easier to find
> in the context of 2.0.xx since many less things were changing....

Do you mean the change from big endian ext2fs to standard little endian
ext2fs?

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
