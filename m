Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 5672DDDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:17:52 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] ib_core: Add missing device link to class device
References: <200704231820.27752.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 23 Apr 2007 12:17:48 -0700
In-Reply-To: <200704231820.27752.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Mon, 23 Apr 2007 18:20:27 +0200")
Message-ID: <ada7is27vdv.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hmm, I have links like this on my system already:

    $ ls -l /sys/class/infiniband/mlx4_0/device
    lrwxrwxrwx 1 root root 0 2007-04-23 12:14 /sys/class/infiniband/mlx4_0/device -> ../../../devices/pci0000:00/0000:00:06.0/0000:0d:00.0

the patch actually looks sane but I don't understand why it's needed.
Could you explain?
