Return-Path: <happyphot@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.233])
	by ozlabs.org (Postfix) with ESMTP id 3E32067B17
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Apr 2006 17:59:19 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i28so78108wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 06 Apr 2006 00:59:18 -0700 (PDT)
Message-ID: <00a301c6594f$ff11c180$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: va_copy() support for powerpc
Date: Thu, 6 Apr 2006 15:59:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
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
  I am trying use "ELDK 4" to build "xorp" for ppc 8xx, but it shows
"configure: error: cannot run test program while cross compiling"
when it checks whether the build environment has va_copy() support.

  How to make the va_copy() be supported by powerpc or ELDK ?
Does anybody know this ?

thank you,
Phot 
