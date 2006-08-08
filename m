Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5580A67B58
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 01:20:33 +1000 (EST)
Date: Tue, 8 Aug 2006 10:19:40 -0500
To: Lei CL Cheng <chenglcl@cn.ibm.com>
Subject: Re: Umount reiserfs partition caused crash on 2.6.18-rc3-mm2
Message-ID: <20060808151940.GB29823@pb15.lixom.net>
References: <OFBE03114B.A48C7930-ON482571C4.001E80F2-482571C4.0020774E@cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFBE03114B.A48C7930-ON482571C4.001E80F2-482571C4.0020774E@cn.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2006 at 01:57:19PM +0800, Lei CL Cheng wrote:
> Hi,
> 
> I installed latest mm kernel 2.6.18-rc3-mm2 on ppc64 with RHEL4-U3.
> And I made a reiserfs partition by mkfs command in this kernel.
> But when I tried to umount this reiserfs partition, the kernel
> crashed and xmon will be entered.

Hi,

This doesn't at first look seem like a PPC-specific bug. You will probably
get more eyes on the problem if you report it on LKML instead.


-Olof
