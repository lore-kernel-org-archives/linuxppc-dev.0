Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F4D5DDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 13:09:41 +1000 (EST)
Message-ID: <486459EC.7030004@firmworks.com>
Date: Thu, 26 Jun 2008 17:09:32 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Support NAND partitions >4GiB with Open Firmware
References: <48642B50.9060607@firmworks.com>
In-Reply-To: <48642B50.9060607@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A revised version of the patch, addressing some points that Segher
identified, will be issued soon.

So if you want to review the patch as submitted, please be aware that
some stylistic things have already been fixed (u64 instead of u_int64_t
etc, use of of_read_number(), removal of fallback code for broken
device trees).  The info in Documentation/powerpc/booting-without-of.txt
will also be amended.

The overall scheme - using #address-cells and #size-cells to permit 64-bit
offset and sizes - remains unchanged.
