Message-ID: <67505026E29DD311A9AA00508B7315F350A579@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: cpm interrupts
Date: Thu, 26 Oct 2000 10:58:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
Is there any way to see what cpm interrupts are actually registered after
the drivers load?

I want to check the cpm vec table and see what interrupts are using what
values. I keep getting a message when I go to use the hdlcppp driver by
Daris, and I think it is because I register my interrupt on an open using
cpm_install_handler(...) instead of in init.
Kernel msgs.
	loop: registered device at major 7
	eth0: CPM ENET Version 0.2, 00:10:ec:00:1e:cd
	SCC HDLC Driver for PPP v1.0
	(c) Copyright 2000, Simple Network Magic Corporation
	early initialization of device hdlcppp2 is deferred
	Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
	Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya"
Kasprzak.

This happens after my kernel boots. I call ifconfig to bring up hdlcppp2 and
I get this message.

	CPM interrupt c00af4dc replacing c00af4dc

Any insight on what causes this?

Thank you in advance,
--Julia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
