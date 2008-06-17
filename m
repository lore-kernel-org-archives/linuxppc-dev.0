Return-Path: <mike.winter@vecimanetworks.com>
Received: from postoffice.corp.vcom.com (postoffice.vecimanetworks.com
	[139.142.226.178]) by ozlabs.org (Postfix) with ESMTP id 75831DE19E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 07:18:24 +1000 (EST)
Received: from [192.168.228.39] (helo=[192.168.228.39])
	by postoffice.corp.vcom.com with esmtp (Exim 4.52)
	id 1K8gtn-000174-Gc
	for linuxppc-embedded@ozlabs.org; Tue, 17 Jun 2008 13:31:23 -0600
Message-ID: <4858113F.4050203@vecimanetworks.com>
Date: Tue, 17 Jun 2008 13:32:15 -0600
From: Mike Winter <mike.winter@vecimanetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: PCI DMA Problems With 82xx?
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

We are developing with an 8248-based platform, and we have a vendor 
telling us that the PCI hardware is unreliable on this CPU family, in 
particular the DMA functionality.  A quick search of this list doesn't 
turn up any horror stories, although the processor does have some PCI 
errata listed.  Does anybody have any practical experience using PCI on 
the 8248 or similar that they can share with me?   Thanks.
