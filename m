Date: Mon, 2 Aug 1999 14:49:45 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Brad Midgley <brad@pht.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: test & set ppc assembly (libgcj vs. threads)
Message-ID: <19990802144945.A28429@them.org>
References: <Pine.LNX.3.95.990802095050.20647A-100000@pacific.pht.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.95.990802095050.20647A-100000@pacific.pht.com>; from Brad Midgley on Mon, Aug 02, 1999 at 09:54:55AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 02, 1999 at 09:54:55AM -0600, Brad Midgley wrote:
> 
> hi...
> 
> i would like to see libgcj work on ppc. i guess there isn't anyone working
> on it because there is missing stuff even in the cvs version. 
> 
> could one of you ppc assembly gurus put forward the code to do a test &
> set? the header here hopefully provides all the necessary context with
> the x86 and alpha implementations... 


Look at the debian package of libgc4.  We patched this a while ago.

The patch is in the .diff.gz on any debian source mirror (<searches>):
/debian/dists/unstable/main/source/libs/libgc4_*



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
