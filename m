Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 72785679FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 22:27:05 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1148909ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 05:27:03 -0700 (PDT)
Message-ID: <82ecf08e0605220527r4033cff2xbba8a60646f9dfc2@mail.gmail.com>
Date: Mon, 22 May 2006 09:27:03 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>
Subject: Preferred way to configure MTD physical mapping and partitioning
In-Reply-To: <200605221232.14880.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200605221232.14880.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What about configuring it in kernel configuration (using make
menuconfig for example). Most of the configurations can be done
through there (position, size, width, etc)?

Only if you have something out of the ordinary it would be advisable
to use a driver.

If you give us more detail we'll be able to help you better

BTW, you can partition your flash via cmdline

Cheers :)



-- 
-
Thiago Galesi
