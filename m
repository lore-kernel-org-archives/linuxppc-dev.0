From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre8-ben0: should pcmcia work ?
Date: Fri, 14 Dec 2001 17:25:00 +0100
Message-Id: <20011214162500.19231@smtp.adsl.oleane.com>
In-Reply-To: <3C1A006C.9060201@gatekeeper.informatik.fh-dortmund.de>
References: <3C1A006C.9060201@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I installed the kernel-pcmcia-cs (3.1.27-10b) package from YDL 2.1 and tried
>to set the "PCIC" option in /etc/sysconfig/pcmcia to "tcic" and "i82365", but
>both did not work on my tibook. Must I use another socket driver or is some-
>thing broken ?

Try again with yenta_socket

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
