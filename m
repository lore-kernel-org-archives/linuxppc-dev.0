Message-ID: <001901c2ad79$bd3f8560$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Accessing I2C from User Space
Date: Fri, 27 Dec 2002 12:59:49 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Iam working on IBM 440gp. I need to access the IIC registers from the
user space. So I wrote a driver mmap entry point. But I noticed that the
function remap_page_range () takes physical address as unsigned long which
is 32 bits. How do I remap the IIC registers which lie in the 36 bit
physical address space?

Regards,
Aman.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
