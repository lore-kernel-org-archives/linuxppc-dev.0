Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id 82B51679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 03:45:31 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by dell2650.onz.com (Postfix) with ESMTP id 83ABB2B4160
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 10:45:28 -0700 (PDT)
Received: from dell2650.onz.com ([127.0.0.1])
	by localhost (dell2650.onz.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21094-03 for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 10:45:28 -0700 (PDT)
Received: from [192.168.1.101] (unknown [192.168.1.1])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by dell2650.onz.com (Postfix) with ESMTP id 0E1B82B413C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 10:45:28 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <ecc06b51023e6ebd23d075aa3948749e@onz.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Ppc Embedded <linuxppc-embedded@ozlabs.org>
From: Allen Curtis <acurtis@onz.com>
Date: Thu, 16 Jun 2005 10:45:28 -0700
Subject: RFC cpm2_devices DPRAM resource
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Slightly different question than the current thread:

Should the DPRAM appear as it's own platform_device?
Option 1) Specify the portion of the DPRAM used by each device with 
that platform_device definition. (current)

Option 2) Define the whole DPRAM region as its own platform_device 
entry. Move the device DPRAM information to the device specific 
platform structure.

Would this help with a general dpalloc() implementation? It would 
reduce the number of ioremap() regions.

Another thought.
