To: linuxppc-dev@lists.linuxppc.org
Subject: HoWTO support a device connected to the MDIO interface (using I2C)
From: "vishal" <vishal@isofttech.com>
Reply-To: "vishal" <vishal@isofttech.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
Message-Id: <20040720152805.49737518.vishal@isofttech.com>
Date: Tue, 20 Jul 2004 15:28:05 +0530
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,
  I am a bit lost out here and i need some direction. I have a device
that is connected to my MPC 8270 board via the MDIO/SMI interface. I now
wish to provide two kernel API's mdio_read, mdio_write to allow some
kernel code to read and write data to this device on the MDIO bus. the
interface uses an I2C bit banging algorithm. Can any one guide ma as
to how i need to go about writing my requirements? any pointers would
really help this newbie. What do i need to do? I am using the ELDK from
www.denx.de. Linux kernel 2.4.24

Thanks in advance.
regards,
Vishal

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
