Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6BE9@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: HDLC - Char or Network driver? 
Date: Fri, 14 Sep 2001 18:31:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I need to exchange data between an MPC860 and other components over an HDLC
bus. I found a "PPP over HDLC" driver for the MPC850. Out of this I made a
(quick and dirty) new driver for HDLC and it seems to work so I will be able
to make a nice driver out of this but I am unsure whether this needs to be
char driver of a network driver.

>From an application I need to send and receive native HDLC packets, so no
additional protocol is needed.

All examples and documents I find about network-drivers are so IP-related. A
network driver registers itself but how can an application reach it? An
Ethernet driver seems to be linked to the TCP/IP stack by using ifconfig.
But what about an HDLC driver for example?

I posted a similar question before to a news-group and several people
suggested that I write a char-driver. When you write to it, you send a HDLC
packet, when you read from it you get the packets that where received. My
temporary quick-and-dirty driver now is a char-driver. But I still feel a
bit uncomfortable about it.

How would you approach this?

Thanks,
Frederic


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
