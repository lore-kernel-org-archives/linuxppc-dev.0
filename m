Return-Path: <nyvlad@hotmail.com>
Received: from bay0-omc3-s41.bay0.hotmail.com (bay0-omc3-s41.bay0.hotmail.com
	[65.54.246.241]) by ozlabs.org (Postfix) with ESMTP id 3A50ADDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 18:05:27 +1000 (EST)
Message-ID: <BAY108-F200EE1DE64C02CBAD94C61C7940@phx.gbl>
From: "Vladislav Nyaykalo" <nyvlad@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: CPM microcode uploading and CPM reset on MPC8560
Date: Wed, 24 Oct 2007 11:05:23 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello to everyone,

I need to insert a function that uploads CPM microcode and resets CPM 
somewhere during kernel initialization before UART is initialized. Could you 
please suggest me the best suitable place.
Target platform: MPC8560
Kernel: 2.6.10

Regards,
Vlad

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.com/
