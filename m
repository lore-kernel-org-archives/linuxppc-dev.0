Message-ID: <012101c01d7e$097f5b00$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "Linux PPC Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Subject: Any docments analyzing linuxppc kernel and it's policy?
Date: Wed, 13 Sep 2000 20:27:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:
  I am reading the source code of linuxppc mm.  It seems that the process
uses the logical address 0 - 0x7fffffff, and the kernel uses the logical
address 0xc0000000 -- (0xc0000000 + maxium memory). The rest logical address
will not be used by anyone. Am I right?
  Is there any document analyzing the linuxppc kernel and how does the
kernel arrange all the logical space ?


Thanks
Gong Zhuo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
