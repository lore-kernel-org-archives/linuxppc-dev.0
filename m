Date: Wed, 7 Jul 1999 13:03:17 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: cc/gcc/egcs kernel compilation options?
Message-ID: <19990707130317.A21114@drow.res.cmu.edu>
References: <199907012249.XAA05762@calvin.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199907012249.XAA05762@calvin.demon.co.uk>; from Barrie Spence on Thu, Jul 01, 1999 at 10:49:57PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 01, 1999 at 10:49:57PM +0000, Barrie Spence wrote:
> 
> As a PPC newbie, why do we need/use "-msoft-float"? Is this 
> to handle some processor implementations that don't have 
> floating-point hardware? (and if so, does it have any overhead 
> on the 603/604/G3 Macs?). If it does have some cost, could it 
> not be enabled in the same way as on Intel?
> 
> Next question, is there any advantage to building a kernel
> with "-mcpu=604 -mtune=604"? (or whatever is most appropriate).

Floating point operations in the kernel are pretty rare, and thus do
not need to be optimized for speed; soft-float is thus acceptable.  The
advantage is that we don't need to save/restore the FPU registers and
state nearly as often.  And I do not know why x86 does not have this
issue.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
