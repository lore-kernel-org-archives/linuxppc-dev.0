From: "gguevel" <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How to use 802.2/LLC on MPC860 board ?
Date: Fri, 22 Jun 2001 18:57:04 +0200
Message-ID: <000001c0fb3c$5dd19640$3101a8c0@DOMAIN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I work on a MPC860 board with a FEC device. I use Montavista Linux 2.2.14
kernel on this board.

I want to use simultaneously IP and LLC layers on the same FEC device.

For LLC, I just have to send some unumbered frames and answer to TEST and
XID requests.

I looked at the code in net/802 directory and I found what I wanted.

But I don't known how a user application can talk to this LLC layer.

Do I use a socket ? What family, address and so on must I specify ?
Do I use send , sento, recv or recvfrom functions ?


Some help or any example will be welcome.

Thank you
Best regards

Gérard Guevel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
