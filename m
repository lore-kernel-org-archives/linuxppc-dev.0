Date: Fri, 15 Oct 1999 23:45:14 -0400 (EDT)
From: Morningstar <elfboy@antioch-college.edu>
Reply-To: Morningstar <elfboy@antioch-college.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: can't compile SAINT
In-Reply-To: <19991016004637.10758.rocketmail@web1004.mail.yahoo.com>
Message-ID: <Pine.GSO.3.96.991015233150.27237A-100000@college.antioch-college.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 15 Oct 1999, Dan Bethe wrote:

> 	I'm trying to compile SAINT, from
> http://www.wwdsi.com/saint/downloads/saint-1.4.beta4.tar.gz.

<snip>

> following output, has anything to do with any specific
> part of LinuxPPC?  This application builds perfectly
> on Solaris 7 / SPARC.  Thank you very much!
>
> make[2]: Entering directory
> `/usr/local/src/saint-1.4/src/port_scan'
> cc -O -I/usr/local/src/saint-1.4/include/glibc21 
> -I/usr/local/src/saint-1.4/include -D_BSD_SOURCE
> -DSYS_ERRLIST_DECLARED  -DAUTH_GID_T=int -g   -c
> tcp_scan.c -o tcp_scan.o
> tcp_scan.c: In function `receive_icmp':
> tcp_scan.c:640: structure has no member named `ip_hl'
> tcp_scan.c:667: structure has no member named `ip_hl'

	I had the same problem awhile back. It's in the 
Linux PPC system net includes. As a quick fix, use another 
set of ip headers (I think I used BSD) and it should 
compile. Crude but effective. 


						-Morningstar

		* We dance where angels fear to tread *

  	  * I seek a lover whose kiss is like an open wound *


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
