Date: Tue, 28 Dec 1999 02:59:01 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: DB_THREAD support in Berkeley DB/glibc
Message-ID: <19991228025900.A1950@drow.res.cmu.edu>
References: <Pine.LNX.4.10.9912262058050.21529-100000@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9912262058050.21529-100000@altus.drgw.net>; from hozer@drgw.net on Sun, Dec 26, 1999 at 09:04:12PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If I'm not mistaken, David Huggins-Daines did this recently.  It is in
the debian packages of glibc in the latest release.


On Sun, Dec 26, 1999 at 09:04:12PM -0600, Troy Benjegerdes wrote:
> 
> I've just figured out that the reason openldap doesn't work is that it
> assumes all platforms support the DB_THREAD argument for db_appinit.
> 
> After looking at the glibc/Berkeley DB source, it turns out that all it
> needs is 10 or so lines of ASM for spinlocks.
> 
> Could someone working on glibc developement add the required ASM and get
> this into the mainline distribution? Thanks.
> 
> (look in glibc/db2/mutex, I believe )
> 
> --------------------------------------------------------------------------
> | Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
> |    Unix is user friendly... You just have to be friendly to it first.  |
> | This message composed with 100% free software.    http://www.gnu.org   |
> --------------------------------------------------------------------------
> 
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
