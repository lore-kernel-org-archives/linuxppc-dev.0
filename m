Message-ID: <003501c2baa7$a9e5a720$cc00a8c0@ycigrnd.ycig.com>
From: "leeyang" <leeyang@ycig.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem about 860 fec ping
Date: Mon, 13 Jan 2003 10:01:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kernel:linuxppc_devel 2.4.20-pre7
filesystem:Eldk via NFS

I enable custom MPC860 fec work as 10Mbit,
it works well.But when i ping packet size
which is bigger than 29000 bytes,it never
reponse.I also try with scc ethernet,it has
the same limit.

sure,the other side of "ping" is a desk
pc who can bear "ping X.X.X.X -s 60000".

Have anyone the same problem?

leeyang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
