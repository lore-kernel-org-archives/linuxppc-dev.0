From: THEDREAM@chollian.net
Message-Id: <200109201107.UAA15781@ldap.dacom.co.kr>
Date: Thu, 20 Sep 2001 20:08:53 +0900
To: linuxppc-dev@lists.linuxppc.org
Subject: [Question] I want to use CSCOPE to port Linux kernel.
Reply-To: THEDREAM@chollian.net
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


HI.

I want to use CSCOPE.

I use Redhat 7.1 in my PC.

I tried to install cscope but I had the message as below.

------------------------------------------------------
# rpm -ivh cscope-15.3-1.i386.rpm
error: failed dependencies:
        libncurses.so.4 is needed by cscope-15.3-1
------------------------------------------------------

I have already libncurses.so.5.2

So I tried as below, but I had the same result.
---------------------------------------------------
# ln -s libncurses.so.5.2 libncurses.so.4
# rpm -ivh cscope-15.3-1.i386.rpm
error: failed dependencies:
        libncurses.so.4 is needed by cscope-15.3-1
----------------------------------------------------

What do I do to use CSCOPE ?

Any help could greatly appreciated.

Have a nice day.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
