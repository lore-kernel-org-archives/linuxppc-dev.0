Message-ID: <007b01c07b69$aa98ff70$0664a8c0@centurysys.co.jp>
From: "Glenn Toshi Martin" <glenn@centurysys.co.jp>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <3A5C823A.6353DCE2@home.se>
Subject: 405GP f_dentry panics
Date: Thu, 11 Jan 2001 09:58:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

We have a custom 405GP board and the "Walnut" board. We are using the
2.4-test2 (Version released Nov 26 2000) kernel supplied via the Montavista
web site. Our custom board has an IDE harddisk while the Walnut board uses
NFS. We are experiencing f_dentry = 0 problems when untarring a 750 MB file
(This seems to lead to memory corruption and hence kernel panics). The
problem is more pronounced when using the IDE but nevertheless occurs when
using the Walnut board over NFS. This appears to be a known problem, but
would like to know whether the problem can be fixed, and if so what is
required to fix it? Or is there a better workaround to the ones currently
available?
We have another problem that may relate to the above. During the untar
process of large files including the one mentioned above, we get a file
system error "Could not write to file: bad file descriptor" every now and
then (both NFS and IDE, more frequently on the IDE). Could anyone shed light
on this problem?

Thanks

Glenn


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
