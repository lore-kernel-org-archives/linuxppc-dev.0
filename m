Message-ID: <3C6E5603.5010801@elsoft.ch>
Date: Sat, 16 Feb 2002 13:52:19 +0100
From: "David =?ISO-8859-15?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Several patches against linuxppc_devel-2.4.18-rc1
Content-Type: multipart/mixed;
 boundary="------------000501010500010109080203"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000501010500010109080203
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes the following issues:

    - arch/ppc/kernel/Makefile
       ppc4xx_pm.o missing in export-objs list

    - arch/ppc/kernel/ppc4xx_pm.c
       missing include file + missing #ifdef #endif

    - arch/ppc/kernel/ppc4xx_pic.c
       fixed constant in ppc405_pic_get_irq()
       (NR_IRQS is not necessarily the total number of UIC irqs)

    - arch/ppc/platforms/ibm_ocp.h
       wrong header file included + some little name fixes


Regarding the newly introduce support for cascaded UICs:

Isn't the CONFIG_CASCADING_UIC option redundant?
If (CONFIG_CASCADING_UIC == (NR_UICS > 1)) is true, CONFIG_CASCADING_UIC
could be replace by (NR_UICS > 1).

Dave

--------------000501010500010109080203
Content-Type: application/octet-stream;
 name="linuxppc.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linuxppc.patch.bz2"

QlpoOTFBWSZTWWe3i3EAAYvfgGAwSH///3vv/mS////iUAOKe6q63dLFChKJAo8TKeowaIPU
ZNMgaAaeoxqB5NRo0EokxMIKMmmRoNAAAAAANAASp6RqnpqIaA9IGhoGgAA0AABoDhppkYjC
aYCGATTCMExMhpkaGgEkiaJgmTRgo9TaUZpDQDQAAeoD1DRl8BUQ/oHqxsYpOac7I1aaekcd
e85GTYLc7MNOyhkNEj01UgxUirORtSkrLIxe9kTEFba3DswG0yWcXqaC4UAoVEL7pU+nrdl3
y4OYsWMix3yJQjmsKt5ZleTeRIYUyY7DuRnO0tO7osCFaWgtQvvtRXrP5rSpiS4XOVI9pVRk
UufQD8tqMwonIFBMRNRBwQHxFJEfLyH7eDjSZZ1tbMW9j3RCZmGZoJB94Wh4718rdXrEOFAW
oWQQmBgcJoFpuK+ks5+l7PdoLAZMDBMk0pxyjA0tAQq4XF/WJYaRlmRnOe21Fo0qm2EROLI5
7mQ8NbTTWuMNVcwOdWgcMm3gpRRP6gPYBMj2ngwhy58xkkDYqTQBkO7cRVK0AxROBMSebvZ1
B3sMzSekqhZZIQhAKLVRIxVqRssQa5GNoaVuGqNCq6oluUmJE3qxmtipK9JWkRo1bxi88FMB
G+ESBuwBm1AwDhgGDeGIjrBPE8Xp62R6uAND8DyrLVS62oEldnagA+zUxCGnVOuvcBsMyQvR
FL47XA5c+PvJHkxtrSrKT7KcilCysvBKidAMKH99qNEtVCA4XRIH3GiWNs121SGESUoUy5RU
O5Ez6DANjxGmzTADcwxRVFUX3c/UuBOGkBxKUR7MIwM8ggnsPrBIWIhY0DGOiPB4owUGiGNq
L+FdCK4CPNS1L6CJCe5sYNeneECzEOwYKgJ0diZTKgRqUJJKRjQIum01k8OHCc1o2IZVOE5U
BE57DGIpwTCILKPeFHI9hmMa1iEVy6i8pZSY3OWlRCD6Ca8RSI+m/KD0hPBhl734gLcPpNFI
yQGVkcFCoFoYrOiHaFK69Iw0ItWlLQTLTK35K0SsWEaRQYKtPICI3DMPYWQIom2kmxDzC/cE
JdjUhsI7oAPEK3XQtiucnN0DgVSGFxcNTc8iapK05lBCcSrm55eXkDXICstjE+BOuJkU4BJt
mla/EUNV22SMg4Yao0M0mXh86hgDMBSEiQOeMeQdfxKY3CL4WvkFPc04FjFRYJkpQ+6DOmsp
0f8XckU4UJBnt4tx
--------------000501010500010109080203--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
