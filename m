Date: Fri, 16 Mar 2001 14:10:45 -0500
From: =?ISO-8859-1?Q?S=E9bastien_C=F4t=E9?= <scote1@matrox.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Is the filesystem in ram moved?
Message-ID: <20010316141045.A1370@dyn-52-73.matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a quick question for you.  I load my filesystem (ext2) in ram (at
0x800000) before I start linux and I'm using initrd.  When everything is
loaded, will the filesystem be at the same place in ram or is it moved??  I
couldn't see any place in the code where they could move it but maybe I
missed something.

I'm asking this because I write something to a file once the system is
running but I can't find that file on the filesystem (by searching through
the memory, fopen() on the file won't return an error).  So I can see only
3 possibilities:
	1.  The file hasn't been created for some weird reason
	2.  The filesystem has been moved in ram so I'm not looking at the
right place
	3.  The file is buffered somewhere but hasn't been written to the
filesystem yet.  The filesystem needs to be sync'ed.

So which one do you think it is?

Thanks!

Sébas..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
