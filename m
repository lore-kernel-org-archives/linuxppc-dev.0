Date: Wed, 7 Jul 1999 18:03:35 -0400
From: Daniel Jacobowitz <drow@false.org>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RPX Lite kernel
Message-ID: <19990707180335.A23027@drow.res.cmu.edu>
References: <3783A613.EEB26616@broadlink.com> <Pine.LNX.3.96.990707143312.4962A-100000@liberty.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990707143312.4962A-100000@liberty.chnd1.az.home.com>; from Matt Porter on Wed, Jul 07, 1999 at 02:35:15PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 07, 1999 at 02:35:15PM -0700, Matt Porter wrote:
> 
> On Wed, 7 Jul 1999, Scott Wood wrote:
> 
> > Thanks...  mkdep was taking over all my CPU/RAM on my machine, but it worked fine on another RedHat-5.2 box.  Now all I need is a
> > cross-compiler... any idea where I can get ppc-linux-gcc?
> 
> http://members.home.net/mmporter/cross.html
> 
> Binaries are out of date since I'm developing natively these days, but the
> build process is documented there as well.

And mine's at
<http://www.them.org/~drow/usr.local.powerpc-linux.tar.gz>.  No
documentation, alas, but it's a pretty recent build, binutils and all. 
Just extract in / (all of the files will go in
usr/local/powerpc-linux), and add /usr/local/powerpc-linux/bin to your
path.

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
