Return-Path: <blackfin.kang@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 4F73EDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 12:49:12 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2374988wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Oct 2007 19:49:11 -0700 (PDT)
Message-ID: <a7f827420710151949q33a1179dw540ae9c6da42b27c@mail.gmail.com>
Date: Tue, 16 Oct 2007 10:49:11 +0800
From: Michael.Kang <blackfin.kang@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: About resevation of kernel code and data section in e500 part.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:
         I have some confusions about where the page of kernel text
and data is reserved in linux source ? Hope get some hints here and
thanks in advance.
         I had digged into some related code, but got no anwser:

1. in set_phys_avail [ arch/ppc/mm/init.c : 456] , it seems memory
used by kernel text and data is reserved for bootmem.

2. Then in memmap_init_zone [mm/page_alloc.c:1925] , all the page is
set reserved including the pages used by kernel text and data. And it
seems page->virtual in all the page is set here.

So my question is where the pages used by kernel text and data is set
to reserved in linux source?


-- Thanks
-- Michael.Kang

-- 
www.skyeye.org
