Message-ID: <3BD50D4E.6060401@elsoft.ch>
Date: Tue, 23 Oct 2001 08:25:18 +0200
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Various patches against linuxppc_dev-2.4.13-pre6
Content-Type: multipart/mixed;
 boundary="------------020203010606010607020707"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020203010606010607020707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello again

The attached patch fixes the following issues:

   - arch/ppc/mm/fault.c
      missing get_pteptr() prototype

   - arch/ppc/kernel/i8259.c
      consistent nameing (rather cosmetic change)

   - arch/ppc/ppc_ksyms.c
      missing flush_dcache_all() export

   - arch/ppc/kernel/ppc4xx_setup.c
      added "l" format flag to sprintf() to make compiler happy
      (cosmetic)

   - arch/ppc/kernel/ppc405_pci.c
      adjust include file name


Dave



--------------020203010606010607020707
Content-Type: application/octet-stream;
 name="various_patches-1.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="various_patches-1.bz2"

QlpoOTFBWSZTWcgaPCsAAix/gH4wIABbf///f/ff5L/v//pQBJnrCGGogBqsJJCJgFT1PTJ6
pp4oPSeTSA9I9Ro0Bp6TQ2psU9IZDhoZNNDTI0NMjIMjI0MgMTRk0AZMjEMJEiap6NRqeCn6
TU0ehNBoY2qANDQ0AAD1A0OGhk00NMjQ0yMgyMjQyAxNGTQBkyMQwkkEyaNCmZCZNTyTU9T1
AANGgaHqAAB6Q0vG8IzKAOflbbgLEDGlyiIhMVob3r65O6dGubWVJbTXYzMm70TBxBDoDnto
gkuZzyIr49firQnRyvBbwBhC9YnnnFDnO/v9vwHoPaS3w8pdI1amQqgu0vDdDmG0lqWC6lu7
lbbbb0q4MGCO3J5nnabioRGjbdLuneFCt6Lc9TgyFm4jHNdOqufuIgN02QvBr1DdZUEQyIkU
VZaKTK+L2Vx2TuZSOjtKiChjHb4UQE0zXsGHFLJGbD0yrMyasdn4SJ3qeb4wyLGL7ILOCZ+D
b40Yghg3iGf55MuKF9p6Ym8RQOdu5PJEgdfRCLUQ0NEJDOssbxDCF8bcc1Zq2NfHejJ+qpGm
gcNj6ulzlPEjQjjiENGVLZXFVQRv4Z6KQ4nOUpynH76OT/VuuwK+dwYuC6+92L/cCG+FFVUo
huMgFdcLIrBGxIQ+8s6cpMRVndAmhXGfqSFFbkOS5STHufbJHU5rKRzgaEYCNPPgPRVDZCHB
fAMoOfVldZ5MsrJSpq2q0i17s4fGy0m2EmmTVa3q1kpVVpnoNfQkDRTMhlmScR4iO3ELGTRT
g4JW3a67nvCAWXzhKPeubAGAvIIbWDOBDI8aOQti8olBKCXRh06nizavu0ihszPrYJU2gxWh
NpOmqqaTOaxMfyGUvATvbF5hQxmNafkfuLI0FABpeAn1y23C/MWymUVUJ925IKIeDrT5hTi7
BeDh+CZmY9t7bZxzP7osfJJxL48CecjndkVdfG2iN6z8r7lOdTRk0Yy724vfLE0X05ZGjpQ0
vNigcquxXrkbi9HoRWSk/UjvzInoLdPP4da53Lr6fkkBQ70lDWC+dzlrHNf3EzluRC8Xia1B
ECwPrOoDDke597JMi2MBYpkG1eCdHmWFqfMC9xvOd2E6CHZoLbMnrX4wnFxbk9dWwZH+yByI
XiKFFEUZoNvn5Qk0gboBjuFR0OzU7Ho7HJ/mnr0KA7n0naWQMQqG+GYStqS2FrLa29tHFIhi
n9ZohhUBxcyXrzclzc2od/jHyxOajzNei6dQ/xGKOEngbLakrQblqqDwjtqIxSwaNAYNlGRu
xOtX7w7Qb1OFLxY5I4oeBeHHbi2pGDtXC6p3Qr/Sw3XgcBOP+Se/FzAUePf2BYKCIkJFrA5B
wrwnwA02ehd4rYEUd8qbuvVNt7lin1WXJJdJugnDbmLnkEqNNjkDCt56XgwA7c0YWFsp0GiI
WFYou2+lkDG4B1cweXYChU4KyYb0PjxVvOZmauhUE/iFQrccwvGd1y3GzfXQ0VJ0aV+yEPQj
LuCMGtshhcREHEPYJixpOUmFIL+xtgqgenx4h0I9EjAOKlaMUoYZLdoCjtlvocFls/Aqii4q
25hUL/i7kinChIZA0eFY
--------------020203010606010607020707--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
