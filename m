Date: Sun, 26 Dec 1999 21:04:12 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: DB_THREAD support in Berkeley DB/glibc
Message-ID: <Pine.LNX.4.10.9912262058050.21529-100000@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just figured out that the reason openldap doesn't work is that it
assumes all platforms support the DB_THREAD argument for db_appinit.

After looking at the glibc/Berkeley DB source, it turns out that all it
needs is 10 or so lines of ASM for spinlocks.

Could someone working on glibc developement add the required ASM and get
this into the mainline distribution? Thanks.

(look in glibc/db2/mutex, I believe )

--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
