Message-ID: <3C57F9AC.9040008@elsoft.ch>
Date: Wed, 30 Jan 2002 14:48:28 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] 3 patches against linuxppc_dev-2.4.18-pre7
Content-Type: multipart/mixed;
 boundary="------------010703050109080107060507"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010703050109080107060507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes the following issues:

    - arch/ppc/kernel/ppc4xx_pic.c
       fixed constant in ppc405_pic_get_irq()
       (should be NR_AIC_IRQS as in ppc403_pic_get_irq())

    - arch/ppc/kernel/ppc_ksyms.c
       added "consistent_sync_page"

    - drivers/net/ppc405_enet.c
       fixed old style register definitions in debug code


Dave



--------------010703050109080107060507
Content-Type: application/octet-stream;
 name="linuxppc.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linuxppc.patch.bz2"

QlpoOTFBWSZTWYbOJ9AAAeDfgCkwW3//+3+//uS/7/9qUAR5621Up5qyABhqRNGjTTQNBphA
AyAAGRoGgYhg4BhGE0xDAIBkAMI0yZMIwENBIiQp5Kekb1TZTan6k8poDamQyDQZGj1NA0NG
QbUqn4iZTJtQ9IaBkAMTINNNA0MjQNDIEkSZMqn40IyCZQ0TTajQGmj0jTagAabUyPUzirxs
12s5yCvllIHEXMhSoRLUtbBfuUyWyRAWObHBytdTDqlQilQ4W9MGKlt00W2nDrqZaMQM1+T6
sWF1IQcawQDFee/rukB27wuPY7+45nZBGLoIkY9ZLdNLN3TF+ZLG79/QYDcq28dpdBbBgBz4
H/8CygoROSAcUMdisTReYWATnOzCXwEKAXWMAnV4v4V8akQ6beXO/3m28kjadUgg57jQLj0X
I4nwRMhwG0EAaV0wf03BMzdylF8QYQQwgHw83J2Ye9bvnCHgvxgWLWJAgoOzebqoedVBxgRu
F4xMr5AmVraRVmNb2GHm349sMikzNLhHiWNqFCDEZhhoH2iy03juO5kHnWODSI+8t8ujM35z
+ldTi5CqePKCHsyf4hLLg2OHA2/JI+MKyyhVXTrTcKMDIMsSqsizGOGW2kKVLZSaQGQEUVNe
VFJ2+9ItBFWaQ7OiMsICmT9DkxgsqPSLYwGcnvddVc23VUiqq/i7/AjOV7MyNAVsNHCLKkxs
TGJrupwbSXEASBQDAP4PnpqUo1JHyKL7KqR0aFiSNdyZx6pDJYx5O0jhuTmHfIKiUCj0EHEi
OxhkzClFjfMleyCdGxAgRGfWiTJEROoxdi9iIrtRlYoLfC8FBXDhejI2uvaYKVUak1RKmCe8
eKQU9fSwactNCzhsh3k8GTJTDxQ4S91jI9K+wGYDu83pkI61HJwCfyWL/kEgeMlJTsGY1kk2
LMTqJCSOgVfaqRclynSYdewWwnzm7ofK8/Gg/Ivxf0ysiBQBwtvblVSGqtE5S7EMbrgGFTuF
b3kmBlxidqcnlQMj1WBFGCKCqcLEBzRruXK3wx2nPOa61g6qLdimOSCJjyZI0LTVNqf6iIXB
gmD2krIK7BXiLADCALVAyOIGqZUqVfGleaDooU3G7MAcDnlATrYiiMkZLRUtWuOZMZXImZr9
6BxOjAXTNYBzMFqargwDhktyiggURLgbGQ3ChNkImFUUyojwICuzyLO0Ue4IG+JG9GsR1pmh
6aBbmrAZBgVEcUdAy5BZePNie1APCDM5CBpMEmDAqDdDMux3Tep05YMwzhpLZnVG+9LbkY8i
GyJxqV+jaGjFMbwqYodGDYCs8jG5VshknfuVqzLvEK9ti4cH3xFr0o8a4o3Mr5bxXlQZkMzH
ECMROEEMWAFiCAUvKNIVsrcxcEB5aQ05ySJszIGZKUUwxX1KHGYTimFGv8XckU4UJCGzifQA

--------------010703050109080107060507--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
