Message-ID: <3B7787FB.E913F22A@fideltronik.com>
Date: Mon, 13 Aug 2001 09:55:39 +0200
From: Pawel Zawora <pzawora@fideltronik.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: NFS mounting timeout
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I use rom file system as a root fs. When I try to mount nfs in my root
fs an error occurs.
(mount -t nfs 192.168.1.1:/nfs /nfs)
After about 2 minutes kernel writes: "portmaper: time out".
What I should do?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
