Message-ID: <001801c2b161$5fa973c0$faffa8c0@VISHWANATH>
From: "Vishwanath" <vishwanath@mistralsoftware.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: ioremap64 and remap_page_range in 440GP
Date: Wed, 1 Jan 2003 12:15:29 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

In PPC Linux, to bring a particular IO page onto Linux addressing space, we
use ioremap64(). Is my understanding correct? If I want to map this remapped
address on user space, I have to use  remap_page_range() of kernel in my
driver.  remap_page_range() takes a 32-bit physical address as argument. But
in 440GP, all addresses are 36-bit with respect to processor. Is there any
64-bit equivalent of remap_page_range(). If it exists, how to use it?

Please help me out since I am stuck while mapping an external peripheral
registers onto user space.

Thanks in advance.

Regards,
vishwa

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
