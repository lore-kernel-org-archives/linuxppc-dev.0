Message-ID: <3CD1382D.8060109@elsoft.ch>
Date: Thu, 02 May 2002 14:59:25 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Several patches against linuxppc_devel-2.4.19-pre7
Content-Type: multipart/mixed;
 boundary="------------000109070206050004060009"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000109070206050004060009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes the following issues:

    - arch/ppc/kernel/ocp_uart.c
       fixes problem with "ghost" uart device

       I'm not sure if this is the correct fix or if
       the semantic of ocp_register() should be changed?

    - drivers/char/ibm_ocp_gpio.c
       fixes typo ([pv]start instead of [pv]addr)

    - arch/ppc/platforms/Makefile
       include ibm405gp.o into export-objs list

    - arch/ppc/platforms/ibm405gp.c
       export base address symbols for use with modularized
       OCP device drivers

       Shouldn't IIC_ADDR also be "const struct"?

    - include/asm-ppc/floppy.h
       fixes swapped arguments of {fd_}outb


Dave


--------------000109070206050004060009
Content-Type: application/octet-stream;
 name="linux-2.4.19-pre7.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-2.4.19-pre7.patch.bz2"

QlpoOTFBWSZTWQFwT9AAAhHfgGYwX3///3/n3/6////qUAUZ7a6Nwm525gdHQhJEQp6KeE2K
n6amUaPUaPTJqPUYgzUNNBoAG1PSaDKBGpqe0U/JDU9ENAAAAZDQBoAANASJNSnoaCZTTNQ0
PKaAaeoeoANNPSepp6g0aBo9QcNDJpoaZGhpkZBkZGhkBiaMmgDJkYhhJEBEwQAmmmqflQya
ABoep6IAAPU0MQbBlEMNk/Bswc6bikaiZbig3JEDMpCgaNWlHGOKIUsbb3LO1abB6/8Usz1H
3lsibi3wZJo2jz5NcxWvQOkRacLmrGuxGYfGki0M03YN4I62TgWicaKHIeiRBrpRgs3mWYz5
332sS/li/t5dTJkcPI4f0xmbv4KUtmCqqMT8BQ21f0YBc37qqb5uRcqLtlgV4ZNh3KRrcVEf
d6ZN3BkyqfJO0s1FE+1kRmRvxR5rc51Ckta51SQ54+GxGvEpGCJVNy5bTCQIRGbQuiUjQpSE
MnOPrhJsKMWs6OQZxkcEWbyE6Jv9ahLLX9dFUDnd32jSbN4xvA6L1641xfdrjS8u2jGliQwy
GQ6VI6DTKZeY7uTS1nFxyQjF4F8xHYXeQ3UOh0X0qmeQzp8ojHOGIhuM63c16di3tm7NNcLF
KMnRuK/m57bvKV3OtPoUq1dUZyTYJnF2oHMLj1hHy/gyBuQHBRn6T9I0ZV/JxDWdo0Fz8Pd7
UUSKDWXFvlggmYeEHEUa65072F865WGAWlll0t/f5eaOdgUKX3wsZ8Zoi0BY0xm2irY4wmNQ
D2ZSpIkUncPOk7Rgj1l5CDRi9bXHFlQ8lp1lTr2sphODrs4XwrRE0gW+y0LgEMW0PGmqAhoz
I3hbmgSlKUuVa0GiN78/ZFVaqgbMl33mORUw/MmpiX5QQcspKg6uBaLdEmvpsSmdtZMWoZfR
PzxMNAjnSB9BbOQMsfiAGzUk1jJLQLMcrsJNaTrKyILCWwlELZMDgMAAwhoX7onZSQ+wSiYr
M1ACK9jSAijluiirMlTQ7AaQxGCcktaVyz+x9dhNk5q1LNxc7j2U1AywNGNZ2iVtNHgL+FK1
Xt8zBeFfUM/E0wj2JmpTxLykFbVbrCmnkHOq7hUBav2/Iq+6Sxsdh7xFFTjSuIsvVjZiD5I+
CDSgugoWAzO6C5RsQSh8NgiGjbkEDoGKDzsrWF3oyKIO8Ua+uzf3AQ4cSLiyHdVx2qYrqsjq
z3nWxSig+6rhs8cUf4GZRgimIiB5laJxTUX7Gz+hzItGKsD2J1bGRfkPA7uGnBGOhBrWCUcm
kcZp3X7okB6fjFRUXNaEDCZW+AM8L1QZNctXZqUU6wv7BVJSEztabBdBBCGJ83n3lPMtpARQ
R4g1nRONWMZybJzGkKwgwNBjqIGIBnvkyLRY9wAgBJKp6ilaJN/pEzpFrCuU1MIHq3hCC3sJ
gGErzmN18U2KayNunxNwIPaEF1PtS3gWay8uIZW6ZKGlSbSzcIlEaxg16rwUKiDVEVvH+hl4
zcpILl3KpgLlV1YQvusY87IKlIJqRkGiOErruup3tkC7mgbsBFEr8yzf9kERRWITAYDgFVD0
HCbHgR0nxWxMrinLUbFguqROOq6C4m7rs24Fj0g65DgoMi+BsC+QiCqlhYYRCa4BgjAzA5w+
rANCFqupWpvN42kThMV9q4+oVJ2ahFHRNu3YLGQ2xGbWpgoBlw/8XckU4UJABcE/QA==
--------------000109070206050004060009--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
