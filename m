Return-Path: <hilichen2000@msn.com>
Received: from hotmail.com (bay110-f40.bay110.hotmail.com [65.54.229.50])
	by ozlabs.org (Postfix) with ESMTP id A9827679F0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Jun 2006 18:14:16 +1000 (EST)
Message-ID: <BAY110-F4002B7619F83B2E70939DEC3860@phx.gbl>
From: =?gb2312?B?s8Ig1MY=?= <hilichen2000@msn.com>
To: linuxppc-embedded@ozlabs.org
Subject: could linux support to configure the PLB-PCI bridge of PPC440 into
	adapter mode
Date: Mon, 19 Jun 2006 15:57:08 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,now I want to use PPC440GX as PCI adapter card bridge. according to user 
manual, the PLB-PCI bridge should be configured to Adapter mode. after 
check some code of PCI of linux, i find the linux only support configuring 
the PLB-PCI bridge into HOST mode. Is my understanding correct ? if the 
normal version of linux don't support the adapter mode, could i found the 
patch?

best regards and thank you.

 chen

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
