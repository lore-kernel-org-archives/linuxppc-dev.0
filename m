Date: Wed, 1 Mar 2000 12:45:09 -0800
Message-Id: <200003012045.MAA19439@www.geocrawler.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Where to insert Snoop
From: "Joshua Liew" <archiver@db.geocrawler.com>
Reply-To: "Joshua Liew" <jliew@pacific.net.sg>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm doing some research on the Berkeley Snoop Protocol and I have some difficulty looking for
the function that calls ip_rcv. I'm using a normal ethernet LAN and need to insert the snoop_ctrl
function before IPv4 receives the packets.....I'm also using Linux SuSE 6.3 with the Kernel
version of 2.2.13.

Thanks,
Joshua


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
