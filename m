Return-Path: <kriti.dutta@oracle.com>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99A3168A2D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 02:02:47 +1100 (EST)
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.186.112])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	k0BF2hlC026868
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 09:02:43 -0600
Received: from rgmgw3.us.oracle.com (localhost [127.0.0.1])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id
	k0BF2hko022782
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 08:02:43 -0700
Received: from kduttapc
	(dhcp-idc-lexington-towers-152-69-159-183.idc.oracle.com
	[152.69.159.183])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with SMTP id
	k0BF2euV022492
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 08:02:42 -0700
From: "Kriti Dutta" <kriti.dutta@oracle.com>
To: "linuxppc" <linuxppc-dev@ozlabs.org>
Date: Wed, 11 Jan 2006 20:32:33 +0530
Message-ID: <GGEMIIODJPBLIOCGNLDJEEBNCAAA.kriti.dutta@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0057_01C616EE.26F9F220"
Subject: Compilation error on Linux PPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0057_01C616EE.26F9F220
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit



> While building one of our library,the following error was reported:
> 
> /usr/lib/gcc-lib/powerpc-suse-linux/3.3.3/../../../../lib/crti.o(.text+0x1
> 0): In function `call_gmon_start':
> /usr/src/packages/BUILD/glibc-2.3/cc/csu/crti.S:16: relocation truncated
> to fit: R_PPC_LOCAL24PC _GLOBAL_OFFSET_TABLE_+fffffffffffffffc
> /usr/lib/gcc-lib/powerpc-suse-linux/3.3.3/crtbeginS.o(.text+0xa4): In
> function `__do_global_dtors_aux':
> : relocation truncated to fit: R_PPC_PLTREL24 __cxa_finalize@@GLIBC_2.1.3
> /usr/lib/gcc-lib/powerpc-suse-linux/3.3.3/crtbeginS.o(.fini+0x0):
> relocation truncated to fit: R_PPC_LOCAL24PC .text+4
> /usr/lib/gcc-lib/powerpc-suse-linux/3.3.3/crtendS.o(.init+0x0): relocation
> truncated to fit: R_PPC_LOCAL24PC .text+4
> obj/opt/dcbagg.o(.text+0x10): In function `__sinit65535()':
> : relocation truncated to fit: R_PPC_LOCAL24PC
> _GLOBAL_OFFSET_TABLE_+fffffffffffffffc
> obj/opt/dcbagg.o(.text+0x28): In function `__sinit65535()':
> : relocation truncated to fit: R_PPC_PLTREL24
> _ZNSt8ios_base4InitC1Ev@@GLIBCPP_3.2
> obj/opt/dcbagg.o(.text+0x34): In function `__sinit65535()':
> : relocation truncated to fit: R_PPC_PLTREL24 atexit
> obj/opt/dcbagg.o(.text+0x3c): In function `__sinit65535()':
> : relocation truncated to fit: R_PPC_PLTREL24
> OLLogger_Dest::OLLogger_Dest()
> obj/opt/dcbagg.o(.text+0x48): In function `__sinit65535()':
> : relocation truncated to fit: R_PPC_PLTREL24 atexit
> obj/opt/dcbagg.o(.text+0x7c): In function `__srterm__0()':
> : relocation truncated to fit: R_PPC_LOCAL24PC
> _GLOBAL_OFFSET_TABLE_+fffffffffffffffc
> obj/opt/dcbagg.o(.text+0x90): In function `__srterm__0()':
> : additional relocation overflows omitted from the output
> 
> Its worth mentioning here that we didn't face any such issue while
> building our other libraries and our .o's .
> 
> M/C Details:
> uname -a : -
>  Linux staxj05 2.6.5-7.139-pseries64 #1 SMP Fri Jan 14 15:41:33 UTC 2005
> ppc64 ppc64 ppc64 GNU/Linux
> 
> xlC Version : -
>   xlC 7.0
> 
> gcc -v : -
>   gcc version 3.3.3 (SuSE Linux)
>   
> 
>  
>  With regards
>    Kriti.

------=_NextPart_000_0057_01C616EE.26F9F220
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
AAAAAABGAAAAAFSFAAABAAAABAAAADkuMAAeAAqACCAGAAAAAADAAAAAAAAARgAAAAA2hQAAAQAA
AAEAAAAAAAAAHgALgAggBgAAAAAAwAAAAAAAAEYAAAAAN4UAAAEAAAABAAAAAAAAAB4ADIAIIAYA
AAAAAMAAAAAAAABGAAAAADiFAAABAAAAAQAAAAAAAAALAA2ACCAGAAAAAADAAAAAAAAARgAAAACC
hQAAAQAAAAsAOoAIIAYAAAAAAMAAAAAAAABGAAAAAA6FAAAAAAAAAwA8gAggBgAAAAAAwAAAAAAA
AEYAAAAAEYUAAAAAAAADAD2ACCAGAAAAAADAAAAAAAAARgAAAAAYhQAAAAAAAAsAXIAIIAYAAAAA
AMAAAAAAAABGAAAAAAaFAAAAAAAAAwBdgAggBgAAAAAAwAAAAAAAAEYAAAAAAYUAAAAAAAACAfgP
AQAAABAAAAB0y7LQLjZmTIjj69A89vUPAgH6DwEAAAAQAAAAdMuy0C42ZkyI4+vQPPb1DwIB+w8B
AAAAnwAAAAAAAAA4obsQBeUQGqG7CAArKlbCAABQU1RQUlguRExMAAAAAAAAAABOSVRB+b+4AQCq
ADfZbgAAAEM6XERvY3VtZW50cyBhbmQgU2V0dGluZ3Nca2R1dHRhLlNULUlEQ1xMb2NhbCBTZXR0
aW5nc1xBcHBsaWNhdGlvbiBEYXRhXE1pY3Jvc29mdFxPdXRsb29rXG91dGxvb2sucHN0AAADAP4P
BQAAAAMADTT9NwAAAgF/AAEAAAA2AAAAPEdHRU1JSU9ESlBCTElPQ0dOTERKRUVCTkNBQUEua3Jp
dGkuZHV0dGFAb3JhY2xlLmNvbT4AAAADAAYQT19opwMABxBpBgAAAwAQEAEAAAADABEQAQAAAB4A
CBABAAAAZQAAAFdISUxFQlVJTERJTkdPTkVPRk9VUkxJQlJBUlksVEhFRk9MTE9XSU5HRVJST1JX
QVNSRVBPUlRFRDovVVNSL0xJQi9HQ0MtTElCL1BPV0VSUEMtU1VTRS1MSU5VWC8zMzMvLy8AAAAA
wow=

------=_NextPart_000_0057_01C616EE.26F9F220--
