Content-Type: text/plain;
  charset="iso-8859-15"
From: Stefan Nunninger <nunnodda@cs.tu-berlin.de>
Reply-To: nunninger@web.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: NFS mount error
Date: Fri, 31 Aug 2001 21:50:25 +0200
MIME-Version: 1.0
Message-Id: <01083121502500.01608@willy>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Sorry this is slightly off topic but probably someone has seen this error
before.

I've been using a embedded device running Linux quite some time no
without problems. Linux mounted it's file system from a NFS server running
on a Red Hat 6.0 machine. Recently I had to change the server. The new NFS
server is running on a SuSE 7.2 distribution. Now my embedded device is not
able anymore to mount it's file system. This is what I get to see:
...
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 56k init
unlock_kernel
Warning: unable to open an initial console.
RPC: sendmsg returned error 101
nfs: server 192.168.0.1 not responding, still trying
RPC: sendmsg returned error 101
nfs: server 192.168.0.1 not responding, still trying

The filesystem is stored in the directory /tftpboot on the NFS server.
The /etc/exports file of the NFS server contains this line:
/tftpboot *(rw,no_root_squash,no_all_squash)

The server is running Linux 2.4.4 (original SuSE kernel) with
userspace NFS daemon 2.2beta47.

The log file of the NFS server shows no error message but this:
mountd[734]: /tftpboot has been mounted by 192.168.0.8

I am able to mount the directory with the file system from another PC.

Has anybody an idea what is the reason for the error message and how it can
be resolved? Thanks for any hint.
	Stefan Nunninger

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
