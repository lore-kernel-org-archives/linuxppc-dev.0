Message-ID: <004101c16d8d$3e64e320$7b80a984@serial>
Reply-To: "Nguyen Trung Thanh" <jari.nguyen@serialsystem.com.sg>
From: "Nguyen Trung Thanh" <jari.nguyen@serialsystem.com.sg>
To: "'Linuxppc-Embedded '" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Brad Parker" <brad@parker.boston.ma.us>
References: <200111141233.HAA74509@p2.parker.boston.ma.us>
Subject: RPX-Lite: USB microcode and SPI/IIC microcode.
Date: Thu, 15 Nov 2001 12:23:14 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Please help me!
Now, I'm using SPI/IIC microcode patch to run SPI and Ethernet
concurrently. Thus, I could not load USB microcode patch to send
SOF.

Would you give me any idea to solve this problem?

Could I load USB microcode patch before I run USB host driver,
then reload SPI/IIC microcode when I unload USB host driver?
Of course, I cannot run SPI or IIC when running USB host driver.

Do you think that this way is applicable?

Do Motorola guys have any microcode patch for all SPI/IIC and USB_SOF? If
they have, it's really realy nice.

Urgent help needed,
Thank you very much,
Jari Nguyen Trung Thanh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
