Message-Id: <s0f7edc2.025@EMAIL>
Date: Fri, 16 Jul 2004 14:55:34 +0530
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Why not kmalloc() ??
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I just figured out that I need to use m8xx_cpm_hostalloc() to allocate memory for "buffer" that needs to be attached to the "Buffer Descriptor" of an  MPC8xx CPM peripheral (like IIC, SPI, SCC etc). Instead, if I try to use kmalloc() or a static memory allocation, my driver isn't working.

1) Can somebody throw some light on what exactly is the difference between m8xx_cpm_hostalloc() and kmalloc().
2) Why is the difference important in ppc linux ?




Thanks
--
Rupesh S


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
