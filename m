Message-ID: <3EC49A6B.6060204@elsoft.ch>
Date: Fri, 16 May 2003 09:59:39 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: [PATCH] RTC_IRQ
Content-Type: multipart/mixed;
 boundary="------------030800070806070308010106"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030800070806070308010106
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello

The attached patch guards RTC_IRQ, so board specific code is able to
change it.

Dave

--------------030800070806070308010106
Content-Type: application/octet-stream;
 name="mc146818rtc.h.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mc146818rtc.h.patch.bz2"

QlpoOTFBWSZTWdDeqJgAAFffgCAwSH//+mtv/AS/Z98iMADttkNQp6TyT1NAGQPKDQNANPUy
ep6gA1JinqNMRk0wTIYmg0GmmTTIZNMMlGmpiNDIAANAaaAGhhGmENDYZk2l8cZ5FVTREEvJ
daILsyfcrEz3WwfKa9Otg95sEcpcKkCTyQ07ZYdAcDjoRGIg1jClTFwTGAKFs4IGisRhkI2G
0GHUdu6ZDygHKRdkqgOqkkBKqCrATGx8QMiCDEioot/gCJjmBjbqGEcXvSidAHYrzvhBwYQO
D7iBecggUpwZSiCzKod6d5a2UgcTEfpUPBYnQshIzQ2HgyFmQ1AnE5qVldgN+lD90PorNUrr
Fhu/aPUv5TeeNx8uiiQ/qLCS/xdyRThQkNDeqJg=
--------------030800070806070308010106--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
