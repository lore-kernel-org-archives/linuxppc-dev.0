Date: Tue, 5 Jan 1999 21:06:09 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: MouseSystems MacoPoint Pro, 3 btn mouse
Message-ID: <19990105210609.A4032@drow.res.cmu.edu>
References: <Pine.CVX.3.93.990106024359.12580B-100000@atlas.cc.uoa.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.CVX.3.93.990106024359.12580B-100000@atlas.cc.uoa.gr>; from Konstantinos Margaritis on Wed, Jan 06, 1999 at 03:01:12AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 06, 1999 at 03:01:12AM +0200, Konstantinos Margaritis wrote:
> (I apologize beforehand in case someone gets annoyed with crossposting)
> 
> I have just bought this mouse, and while it works ok with the mac, I can't
> get it to work in linux (well, it works, but it doesn't use all 3
> buttons). Yes I know, I should get mousemode and do 'mousemode 15 3' or
> something like that, I did search the faq, but found no mention of this
> particular mouse. Problem is that I use Debian/PPC and the mousemode
> included (in package pmac-utils 1.1.1-1) seems to be old, or at least it
> works only with /dev/adb. As I use 2.1.131, the proper device
> is /dev/adbmouse and mousemode fails with an Input/Output Error.
> 
> So, what I really need is either a proper debian package (sorry rpms won't
> do as I use glibc pre2.1), or sources to a working mousemode and if
> possible the word of someone experienced in this sort of thing.

I don't off hand know where to get the latest mousemode, but this might
help: The device is indeed /dev/adb under recent kernels, major number
56, minor 0.  And the command would be mousemode 15 4.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|     CMU, CS class of 2002      |
|   Debian GNU/Linux Developer    __   Part-Time Systems Programmer  |
|         dan@debian.org         |  |        drow@cs.cmu.edu         |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
