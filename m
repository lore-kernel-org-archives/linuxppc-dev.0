Date: Thu, 26 Oct 2000 16:19:05 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18pre17 again
In-Reply-To: <14839.53124.753011.489351@argo.linuxcare.com.au>
Message-ID: <Pine.HPX.4.10.10010261615340.15431-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 26 Oct 2000, Paul Mackerras wrote:

>
> I have updated my rsync trees with some more changes to my current
> 2.2.18pre17 source, mostly to allow a range of configs to compile
> successfully.  I have also checked in the changes to the linuxppc_2_2
> bk tree.  Prep-only configs should compile ok now and as a bonus they
> no longer include all the pmac and chrp code that they used to.
>
> If anyone gets compile errors with my 2.2.18pre17 tree, or the current
> bk tree, please send me your .config.  I'm making a collection. :)

Are you truly interested in my configs with VME support for MVME boards, a
different bootloader and many many other details ? Plus the negative
patches for the stupid things that are in the official kernel and which
will never, ever, make it to my own tree.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
