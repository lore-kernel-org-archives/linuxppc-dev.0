Return-Path: <prashant.alange@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.198])
	by ozlabs.org (Postfix) with ESMTP id 3AB9167F90
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 12:30:50 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so1402495rne
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 08 Aug 2005 19:30:49 -0700 (PDT)
Message-ID: <6d145b42050808193058ee05b4@mail.gmail.com>
Date: Mon, 8 Aug 2005 19:30:49 -0700
From: Prashant Alange <prashant.alange@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: How to disable dcache on MPC82xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am using alloc_bootmem_page() function to allocate memory required
in my custom ethernet driver . This driver reads buffer descriptors &
data from the memory allocated by bootmem page. This memory is updated
by CPM module. I am experiencing reliability issues with this driver.
It works fine for some time & then behaves abnormally. When driver
fails,  the values read from the allocated memory does not make any
sense. So I am thinking this could be because of cache since this
driver is working fine on non-os platform. I want to disable the
dcache for this memory region.

I am allocating about 700K of memory using alloc_bootmem_page() function.

Can anyone tell me how to do this?=20

I am running linux-2.4 on MCP8270 processor.

I tried flushing the dcache before accessing the memory but no luck.

Thanks for your time,
Prashant
