Date: Sat, 16 Oct 1999 10:31:55 -0400 (EDT)
From: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
To: Dan Bethe <dan_bethe@yahoo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: can't compile SAINT
In-Reply-To: <19991016004637.10758.rocketmail@web1004.mail.yahoo.com>
Message-ID: <Pine.SOL.3.96.991016102956.10625A-100000@mcmail.cis.McMaster.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wouldn't bother with saint, try nessus which is very current & actively
supported.  furthermore there is  a very helpful and small usergroup.
www.nessus.org

--------
Paul Barrette
Ph.D. Candidate Classics (Latin Literature)
System Administrator (Linux/Unix specialist)
McMaster University
http://www.humanities.mcmaster.ca/~barrette/

"Oppositaque ad os manu nescio quid taetrum 
exsibilavit, quod postea Graecum esse affirmabat."
                                      --Petronius

On Fri, 15 Oct 1999, Dan Bethe wrote:

> 
> 	Hi guys.  If this issue belongs more on
> linuxppc-user, just say so.
> 	I'm trying to compile SAINT, from
> http://www.wwdsi.com/saint/downloads/saint-1.4.beta4.tar.gz.
> 	I have a Powerbook G3 series Wallstreet II, with
> LinuxPPC 1999 (not Q3).  Stock glibc-devel 2.2.1-6c. 
> "Reading specs from
> /usr/lib/gcc-lib/ppc-redhat-linux/egcs-2.91.66/specs
> gcc version egcs-2.91.66 19990314 (egcs-1.1.2
> release)"
> 	Can you simply tell me if the problem from the
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
> 
> =====
> "Don't expect your own messiah; this neverworld which you desire is
> only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
