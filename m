From: ajay.kunnath@exgate.tek.com
Message-ID: <21F9768AF088D211BF1C0008C71E5786013C9E07@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IIC write
Date: Wed, 4 Oct 2000 11:25:20 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I need to write some data into an EEPROM using the iic bus. From the MPC860
user manual I was not able to figure out the method to send the trasmit
buffer.

As per the manual, I need to mention the device address as the first byte to
be transmitted i.e. first byte in tbdf->cbd_bufadr . If so, where do I
mention
the actual buffer which contains the data that needs to be written to the
EEPROM ?

I would greatly appreciate any help.

Thanks,
Ajay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
