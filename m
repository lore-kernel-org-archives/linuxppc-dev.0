Message-Id: <20010905160606.Postino-024904@smtp01.highway.ne.jp>
Date: Wed, 5 Sep 2001 16:06:06 +0900
To: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: BOOT PROBLEM recent kernels with  gcc 3.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I have this problem for a long time.
gcc3.0.1 was able to rebuild bootable linux-2.2.19,and linux-2.4.7 from bk
tree. those kernel was successfull with gcc-3.0.1.

But all recent kernels are not able to boot with gcc-3.0.1 ,
which are linux-2.4.9 Ben's,linux-2.4.10pre3(BK tree)
and linux-2.4.10pre3(BK devel tree).
I had fail with all recent kernels when using gcc-3.0.1.

Those compilation is no poblem.
I have said  this to Mark who is gcc3's maintainer,his answer was not gcc bug.

Any help!

Kaoru

--------- the error from OF ---------
... ok
copying OF device tree...
DEFAULT CATCH!, code=300 at  %SRR0: 0132ec  %SRR1: 00003030
 ok
 0 > _


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
