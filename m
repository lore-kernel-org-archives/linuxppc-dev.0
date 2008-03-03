Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 6CA1DDDF3C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 09:44:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: locking problem in sata_sil24?
Date: Mon, 3 Mar 2008 16:44:41 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
In-Reply-To: <1204583866.21545.31.camel@pasglop>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
	<1204583866.21545.31.camel@pasglop>
From: "Rune Torgersen" <runet@innovsys.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2008-03-03 at 16:10 -0600, Rune Torgersen wrote:
>> Hi I am trying to get PREEMPT_RT pach to wokr on my 2.6.24 kernel,

> What core is in the 8280 ? At this stage, I wouldn't rule out a bug in
> the lockdep patches, I need to do more work on them.

Should be an 603e
adn revision (from u-boot)
CPU:   MPC8280 (HiP7 Rev 14, Mask 1.0 1K49M) at 447.897 MHz



I am currently compiling a LOCKDEP kernel for my x86 desktop, as it has
the exact same SiliconImage controller on a card, so I'll see if it gets
a similar detection.
