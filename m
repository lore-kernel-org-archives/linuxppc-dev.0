Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: "'Lokesh Kumar'" <lokesh.kumar@wrx-us.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: scc1 serial
Date: Fri, 22 Aug 2003 12:41:22 +0800
Message-ID: <000201c36867$a3a58600$9f02a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158D66@norcom2.norcom.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You should read the file uart.c (\arch\ppc\8xx_io\uart.c), and give you some modification.

luck to you.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Lokesh
Kumar
Sent: Thursday, August 21, 2003 5:38 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: scc1 serial



Hi Everybody,
I have 855T based board, and have 2.4.18 kernel on it. The console is on
SMC1. I want to configure SCC1 as serial as well. To do that, I took uart.c
file from denx eldk, and the Config.in as well. My question -

is that it, or do I need to change any more files, before I configure SCC1
and UART?

Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
