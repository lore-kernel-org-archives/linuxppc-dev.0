Message-ID: <3E06CEF9.1080300@elsoft.ch>
Date: Mon, 23 Dec 2002 09:53:13 +0100
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Missing #ifndef in pci-dma.c (linuxppc-2.5)
Content-Type: multipart/mixed;
 boundary="------------060106000808030107090007"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060106000808030107090007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes a little problem for not cache coherent cpus.


BTW

Merry X-mas and a Happy New Year

Dave

--------------060106000808030107090007
Content-Type: application/octet-stream;
 name="pci-dma.c.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pci-dma.c.patch.bz2"

QlpoOTFBWSZTWVv6d4gAAEzfgCAwaH/7+m/nngC/b98aMADra2GoCmTZQAeoGmg0ABo2kaM1
AMpT0xJk00MahkAAAAAA0GiaoM1B6Q0aaGgAZNAHqGgGmEIB+YMYoi+m/d4oiYFJMsEc9C/e
hsMyUIUlrdC/bC23ZTwqpW467Ah2TWiGZbAhDFYC0OOdziHUyQtPk+C7MJRAErMCRBGhJRZY
QU3NYVShWcimB+EXhpYoA4MgUqWbadASTFbK9NLHPGEK6rfEBzmSWceKdjKQNXkQVs5OEhHE
KQw3gwcZTSz+WCqODhPePf0mNMBoeNpPmVTEudA7ATpIQXQlD/ZMyTF9DkpeBWfpa/OwxVEt
WoiBYjTTnWFIeR/F3JFOFCQW/p3iAA==
--------------060106000808030107090007--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
