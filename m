Message-ID: <E1836A7F3557D311A14000805F9F36FC0151888C@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: I2C external interrupt
Date: Wed, 20 Feb 2002 21:16:26 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

OK, I have successfully implemented an I2C I/F on my
Embedded Planet MPC823e platform (Linux kernel
2.2.14 HHL). Now what I'd like to do is interrupt the 823e
causing the PPC to initiate an I2C Write/Read transfer. I
notice that the I2C driver already installs its interrupt
handler using cpm_install_handler with an irq. Since a device
driver can not have more than 1 associated irq(?), has anyone
attempted to do something of this sort or have any
meaningful suggestions for me?

Regards,
     Michael Pergola
     Software Engineer
     Baltimore, MD  21236     (410) 931-6778 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
