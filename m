Message-Id: <199909281615.JAA21404@soda.CSUA.Berkeley.EDU>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.13 build OOB?; need for some standardization here? 
In-Reply-To: Your message of "Tue, 28 Sep 1999 11:20:20 EDT."
             <199909281522.KAA04793@lists.linuxppc.org>
Date: Tue, 28 Sep 1999 09:15:06 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

See my comments inline.

> Then there is the whole question of where to get your kernel source from?  You 
> can't seem to use the official kernel source trees for even the *stable* relases 
> of 2.2.X.

I'm not sure about other people, but as of kernel version 2.2.12 I was
able to download and compile it using the source from ftp.kernel.org.
No special patches or rsync updates. I just download the bz2 file,
untar'ed it in /usr/src and did:

$ make mrproper ; make pmac_config ; make menu_config ; make dep ; make clean ; make

> Shouldn't the official *stable* kernel tree always build-out-of-the-box on each 
> supported platform?  If so, why isn't this happening in general? 

I'm sure this is the desired *goal* but it isn't true in reality. As
an example, when I was running sparc-linux the stable kernel rarely
compiled "out of the box". Eventually, I gave up and went back to
Solaris (its not that slow once you get rid of all that CDE crap and
just ssh into the box).
 
> The lack of standards for Linux is driving the Blackdown x86 JDK porting crazy. 
> Differnt default ulimits for thread stacks between SuSe, RedHat, and Debian, 
> differnt glibc's, different versions of libraries, different install locations, 
> etc.  

I mainly work on Solaris, and I have seen similar problems before
while trying to port Solaris code to HPUX and AIX which have
completely different conceptions of how things ought to work. In a
some cases we just ended up ditching the HPUX or the AIX port since it
was just too hard and we couldn't afford the time/machines to fully
support it.

One of the reasons (IMHO) that RH and RH based Linux versions are
popular is that they are closer to Solaris in the layout and
management of the system and in the development envrionment than other
versions of Linux. This makes porting easy: 'just type make'.

> Our user base is simply too small to keep that many different distributions 
> around.  If we want, commercial software to be ported to LinuxPPC, we really 
> need to have a unified user base.

Most companies will pick only one or two versions of an OS to
support. This is the only way that they can get any reasonable
development done. Unlike OSS, commercial software has committed
release dates and customer guarentees that cannot be met unless you
limit the scope of your project.

I see this is happening already. For example, most commercial products
for Linux are RH 5.0 or newer. I think that the closer the LinuxPPC
distributions come to RH for x86 the easier it will be to attract
commercial software. In the transition from LinuxPPC R4 to LinuxPPC
R5, I think that the linuxppc.com guys did a pretty good job.

Just my $0.02,

----ranga <ranga@soda.berkeley.edu>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
