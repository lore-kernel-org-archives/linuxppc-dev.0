Message-Id: <199912201808.NAA02902@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting w/out BOOTP and still have IPv4 comeup.
Date: Mon, 20 Dec 1999 13:08:43 -0500
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just a quick question.  I have linux going on an embedded MPC860.  The
application that is running on it uses sockets but when I disable bootp all
the socket calls fail since the network has not been configured properly.
What is the best way to fake this out.  I have tried adding a line similiar
to this to the init string
ip=192.168.1.1:192.168.1.2:192.168.1.254:255.255.255.0:noname:lo:off but
that doesn't seem to help.

Thanks in advance,
Jason

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
