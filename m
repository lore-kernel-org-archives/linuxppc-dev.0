Date: Fri, 22 Oct 1999 22:40:18 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: NFS Root
In-reply-to: <38107A55.179866F0@email.sps.mot.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910222227400.2741-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,


I am trying to boot my MPC860 board via NFS-Root but I am getting
a -13 error. The board did properly get its IP address from a bootp
server. The server also provided the NFS server address, which the
board properly use. I am able to mount the exported file system using
another client (actually, the bootp server; I have 2 stations plus the
860 board).

Is there a good source of information on NFS other then the HOWTO. It
seems a little bit outdated (early 1997); I am using 2.2.12 with kernel
NFS, etc. And it does not rely help in troubleshooting (i.e. what is
error -13?)

Thanks

Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
