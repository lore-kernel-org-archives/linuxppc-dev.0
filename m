Date: 19 Nov 2002 00:01:43 -0000
Message-ID: <20021119000143.24950.qmail@webmail8.rediffmail.com>
MIME-Version: 1.0
From: "sanjay k k" <fren00@rediffmail.com>
Reply-To: "sanjay k k" <fren00@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ioctl call for  i2c driver +PPC440 returns "No such Process"
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi ,
I am writing some i2c based program in user space to read SEEPROM
using ioctl interface. When i tried to tun it says "No such
process". I tried to debug the i2c-algo-ibm-ocp.c code. I found
that analyze_status returns Incomplete transfer. It seems to me
that data transfer on i2c bus has to be slowed down.
For eaxample after putting the slave address on i2c bus and before
putting the data bytes , i need to provide some delay around
100micro sec.
Does any body has idea , how to put theses delays on I2c bus????

Any help will be greatly appreciated!

Thankx
Sanjay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
