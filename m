Date: Fri, 29 Oct 1999 13:22:51 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: segfaults due to mmap (umoven: Input/Output error)
Message-ID: <19991029132251.A1336@drow.res.cmu.edu>
References: <99102917335900.03412@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99102917335900.03412@localhost.localdomain>; from Wolfgang Haeuptli on Fri, Oct 29, 1999 at 05:28:13PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


No, that's not an error in the program, it's an error in strace.  The
latest version of strace corrects it.  You need to get the Debian
package of it; I don't know where else it's available.  The new home
for it isn't up yet.

Look for strace_*.orig.tar.gz in
ftp://ftp.debian.org/debian/dists/unstable/main/source/devel/


On Fri, Oct 29, 1999 at 05:28:13PM +0200, Wolfgang Haeuptli wrote:
> 
> Hello everybody
> 
> Several programs I compiled recently die with a segfault. 
> strace shows: 
> mmap (ptrace: umoven: Inout/Output Error...
> 
> There are lots of remarks about mmap-problems, but I didn't find a clear
> solution. Is that a problem with glibc?
>  I'm using kernel 2.2.9 with glibc-2.1.1-6c. Would a glibc-update fix the 
> problem, or does somebody suggests something else?
> 
> Thanks
> 
> Wolfgang Haeuptli 
> 
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
