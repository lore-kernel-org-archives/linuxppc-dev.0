Return-Path: <patrick.huesmann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 6A698679FA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 04:58:16 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1301890wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 May 2005 11:58:14 -0700 (PDT)
Message-ID: <427FB3A5.5080702@gmail.com>
Date: Mon, 09 May 2005 21:01:57 +0200
From: Patrick Huesmann <patrick.huesmann@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: How to increase kernel stack size?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

is there a way to set the kernel stack size (for interrupts) at compile 
time?
I need to have more stack space for the external interrupt on a PPC-405.

BTW, I'm using a RTAI patch but it shouldn't matter as the realtime 
interrupts use the same stack as Linux interrupts.

TIA,
Patrick
