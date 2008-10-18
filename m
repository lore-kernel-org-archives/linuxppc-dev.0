Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id 7F887DDEEA
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 11:33:42 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so720695wxc.15
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 17:33:40 -0700 (PDT)
Date: Fri, 17 Oct 2008 20:32:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: 4xx 'next' branch updated
Message-ID: <20081018003205.GA27307@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

The follow patches have been added to the 4xx 'next' branch:

Josh Boyer (5):
      powerpc/40x: AMCC PowerPC 405EZ Acadia DTS
      powerpc/40x: Add AMCC PowerPC 405EZ to cputable
      powerpc/40x: Add PowerPC 40x simple platform support
      powerpc/40x: Add cuboot wrapper for Acadia board
      powerpc/40x: Add PowerPC 405EZ Acadia defconfig

Niklaus Giger (1):
      powerpc/40x: Add support for Netstal HCU4 board

Steven A. Falco (1):
      powerpc/4xx: Add PowerPC 4xx GPIO driver

They will sit there over the weekend and then I will probably ask Ben
to pull.  I have one more patch (Ben's PCI ISA thing) that I'll
probably include for 2.6.28 (aside from bug fixes and defconfig updates.)
The rest I'll target for 2.6.29.

josh
