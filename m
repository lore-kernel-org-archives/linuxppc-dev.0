Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 435BDB7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 16:44:46 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 68CE3DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 16:44:44 +1000 (EST)
Received: by fxm22 with SMTP id 22so2244360fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 23:44:41 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 3 Jul 2009 12:14:41 +0530
Message-ID: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
Subject: Inline assembly queries [2]
From: kernel mailz <kernelmailz@googlemail.com>
To: linuxppc-dev@ozlabs.org, gcc-help@gcc.gnu.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Thanks for responding to my previous mail. A few more queries

a. What is the use of adding format specifiers in inline assembly
like
asm volatile("ld%U1%X1 %0,%1":"=r"(ret) : "m"(*ptr) : "memory");

b. using m or Z  with a memory address. I tried replacing m/Z but no change
Is there some guideline ?
gcc documentation says Z is obsolete. Is m/Z replaceable ?

- Manish
