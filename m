Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id D5C1BDDF0C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 11:47:20 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1162497ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Aug 2008 18:47:19 -0700 (PDT)
Subject: 2.6.27 fixes for 4xx tree
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 04 Aug 2008 21:47:10 -0400
Message-Id: <1217900830.2328.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: paulus@samba.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

If you have fixes for 4xx that you want to get in the .27 kernel, please
let me know soon.  I have the following queued up:

Sean MacLennan (3):
      powerpc/4xx: Cleanup Warp for i2c driver changes.
      powerpc/44x: Warp DTS changes for board updates
      powerpc/44x: Incorrect NOR offset in Warp DTS

Valentine Barshak (1):
      powerpc/44x: Adjust warp-nand resource end address

I'll also be updating all the defconfigs for 4xx in the next day or so.
Then I'll ask Paul to pull.

josh
