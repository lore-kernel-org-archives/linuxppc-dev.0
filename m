Date: Sun, 26 Oct 2003 15:20:04 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: SunGem
Message-Id: <20031026152004.2bf89e87.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a Windtunnel G4 and I'm using the SunGem ethernet module. The G4 is
connected to a 10mbps hub. When the hub is turned off or when the eth cable
is not connected at all, it prints these useless messages in the logs all
the time:

Oct 26 15:00:02 localhost kernel: eth0: switching to forced 10bt
Oct 26 15:00:23 localhost kernel: eth0: switching to forced 100bt
Oct 26 15:00:30 localhost kernel: eth0: switching to forced 10bt
Oct 26 15:00:50 localhost kernel: eth0: switching to forced 100bt

Is it supposed to do so ?


--
Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
