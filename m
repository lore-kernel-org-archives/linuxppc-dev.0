Subject: Head of linuxppc bk broken
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: davem@nuts.davemloft.net
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1086597896.5981.9.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Mon, 07 Jun 2004 10:44:57 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Some "sk_"'s too much...

--- /tmp/tcp_input.c    2004-06-07 10:39:25.000000000 +0200
+++ net/ipv4/tcp_input.c        2004-06-07 10:39:55.000000000 +0200
@@ -476,8 +476,8 @@
                                  16 + sizeof(struct sk_buff));
                        space *= rcvmem;
                        space = min(space, sysctl_tcp_rmem[2]);
-                       if (space > sk->sk_rcvbuf)
-                               sk->sk_rcvbuf = space;
+                       if (space > sk->rcvbuf)
+                               sk->rcvbuf = space;
                }
        }

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
