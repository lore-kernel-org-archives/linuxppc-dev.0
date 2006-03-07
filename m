Return-Path: <achim.machura@berghof.com>
Received: from mail92.messagelabs.com (mail92.messagelabs.com [194.106.220.51])
	by ozlabs.org (Postfix) with SMTP id 8AC3F679EA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 22:43:23 +1100 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: <prabha.j@tcs.com>
Subject: AW: help reqd
Date: Tue, 7 Mar 2006 12:36:35 +0100
Message-ID: <001801c641db$64726660$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <OF46AD2988.50343CDA-ON6525712A.003D6847-6525712A.003DEE14@tcs.com>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

> insmod: unresolved symbol copy_to_user 
> insmod: unresolved symbol down 
> insmod: unresolved symbol up 
> insmod: unresolved symbol copy_from_user 

you have to include <asm/uacces.h>


See the online book linux device driver form Alessandro Rubini

aze
