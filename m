Return-Path: <rukseninanir@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 15949DDF30
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 20:32:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so604339ugf.0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 03:32:54 -0700 (PDT)
Message-ID: <487F1FD2.7090909@gmail.com>
Date: Thu, 17 Jul 2008 13:32:50 +0300
From: Ruksen INANIR <rukseninanir@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: increase lowmem value for ppc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Is there a way to increase the lowmem value for ppc. The MAX_LOW_MEM is 
defined as max 768 MB. But a value around 1.5 G works with no problem. 
But when i try to increase this value to 1520 or more, kernel complaints 
about no space for memory allocation when loading kernel modules.
I do not want to use HIGHMEM config. What is the max lowmem value for a 
ppc system? What other setting are needed to use 1520 MB (or more) as 
lowmem .
The ppc card has 2G on board memory. 2.4.22 kernel is used.

Thanks
