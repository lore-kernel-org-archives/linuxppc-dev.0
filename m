Message-Id: <l03130302b4fd80d3a908@[216.164.130.191]>
In-Reply-To: <200003202228.RAA22962@miranda.inetsolve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 21 Mar 2000 14:48:32 -0500
To: "Linux/PCC Development Mailing List" <linuxppc-dev@lists.linuxppc.org>
From: "DeRobertis" <derobert@erols.com>
Subject: stty crtscts < /dev/ttyS1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hardware flow control is broken. The command in the subject line (stty
crtscts < /dev/ttyS1) freezes linux 2.2.14. Any idea why?

I've already grabbed the latest stty.

Oddly, the following line in /etc/ppp/options does not freeze:
	/dev/modem 57600 crtscts

(/dev/modem is a symlink to /dev/ttyS0)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
