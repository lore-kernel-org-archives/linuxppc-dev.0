Message-ID: <3E1EF9B4.3030201@elsoft.ch>
Date: Fri, 10 Jan 2003 17:49:56 +0100
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH]  ppc_ksyms.c (linuxppc-2.5)
Content-Type: multipart/mixed;
 boundary="------------080701080707020902050603"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080701080707020902050603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes two little problems in ppc_ksyms.c.

	- mark "flush_dcache_range" as EXPORT_SYMBOLS
	- "__res" is not only used on 8xx, but also on 4xx

Dave

--------------080701080707020902050603
Content-Type: application/octet-stream;
 name="ppc_ksyms.c.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ppc_ksyms.c.patch.bz2"

QlpoOTFBWSZTWQ3jXkQAAHTfgGAQSH//2lu33GCvb/9kMAF0sDDRCjT0mRoyHqMQDQABoaMQ
BqNJtFPTSAA9QAGgAAAAJIiU8mRo1MagAA00GammmJo9I0VXG0QggmKUATin01Kd8auJyNnR
ZOCGQqyAyOo04Qj3QxJZZIkLlf/B4UxN3gsJMGYdA1ghBdKailkyHQm3G47ADNAMPSFCEqBy
BsmKafcLyVoqwjhFwLKQwdh5oKEtDAGhjFyi8QSfV74yKIkvBUQb0oDZEnbCBjCI62IHHLBG
UgMYcMEMx7iawWcTmgRsEeziziLBaRGwRERWI1CNIjWI1C3fQjEZoZG/IeT5VdJHd22kpmK/
NW2bhZ9CtqRUK9roC4iIw15r8AaJcJ0RVFqOBSYTcnP20KGBgv3zGtjjy0ouqoJNsqkK1FU0
JomJPNUb1ErlgyIGAKVInipvTAqpxSwKRXJlOrpNSZJFe3uc6x8ag0i4lNjimiMqIMDAUolM
qoHsVB/F3JFOFCQDeNeRAA==
--------------080701080707020902050603--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
