Return-Path: <embedway.test@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 56C31B7115
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 15:56:10 +1000 (EST)
Received: by gwj15 with SMTP id 15so1068348gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Sep 2010 22:56:07 -0700 (PDT)
Date: Fri, 10 Sep 2010 13:56:08 +0800
From: "hacklu" <embedway.test@gmail.com>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Subject: how to understand powerpc's BRx ORx
Message-ID: <201009101356067140460@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 I didn't understand the address mask.
it's said that: BR[BA] is the base address,the OR[AM] is the  address mask,
"Provides masking for corresponding BRx bits. By masking address 
bits independently, SDRAM devices of different size address ranges can be used. Clearing 
bits masks the corresponding address bit. Setting bits causes the corresponding address 
bit to be compared with the address pins. Address mask bits can be set or cleared in any 
order, allowing a resource to reside in more than one area of the address map. SDAM can 
be read or written at any time."

how to understand it?
for instance, if my BR0[BA]=0111_0000_0000_0000_0, OR0[AM]=1111_1111_1111
if I want to access the 0x70000000 or the 0x71000001.what address calculate will be taken?

thanks all
 				
--------------
hacklu
2010-09-10
