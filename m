Message-ID: <020201c3d5d2$f37e1240$21589edd@CHKIMVAIO>
From: =?ks_c_5601-1987?B?sejEociv?= <willy@airpoint.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: socket programming without RTnet.
Date: Thu, 8 Jan 2004 19:34:09 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Well, for my socket programming on RTAI patched linux 2.4.20, I tried
to find some socket APIs. But there were any what I expected such as
socket() a standard BSD APIs.

I know I can use the RTnet. But before using it, I want to program a
socket application without the help of RTnet.

Just before I found some APIs starting sys_ net/socket.c like
sys_socket, sys_bind(). To use them I added their symbol in netsyms.c.
And I made a hello-world function using sys_xxx functions.

    Oops: kernel access of bad area

But the problem is that when I loaded my hello-world app as a module
after booting. Why can't I use those APIs? I think loadable module is a
part of kernel.

If I can't use those APIs, is there any good way to make a socket
programming without the help of RTnet?

Willy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
