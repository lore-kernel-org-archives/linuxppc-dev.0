Return-Path: <htejun@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 9466267C3A
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 21:07:26 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so120154nfc
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 02:07:24 -0800 (PST)
Message-ID: <4562CFD4.6040702@gmail.com>
Date: Tue, 21 Nov 2006 19:07:16 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH] drivers/ide: PATA driver	for Celleb
References: <200611210959.kAL9x8eH026223@toshiba.co.jp>
In-Reply-To: <200611210959.kAL9x8eH026223@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akira Iguchi wrote:
> Dear everyone,
> 
> This is the patch (based on 2.6.19-rc4) for PATA controller of
> Toshiba Cell reference set(Celleb). The reference set consists
> of Cell, 512MB memory, Super Companion Chip(SCC) and some
> peripherals such as HDD, GbE, etc. You can see brief explanation
> and picture of Cell reference set at following URLs.
> 
>     http://www.toshiba.co.jp/about/press/2005_09/pr2001.htm
>     http://cell-industries.com/toshiba_announces.php
> 
> We use a drivers/ide driver because its design is more suitable for
> SCC IDE controller than libata driver. Since SCC supports only 32bit
> read/write, we must override many callbacks of ata_port_operations
> by modifying generic helpers. Each time the libata common code is
> updated, we must update those modified helpers. It is very hard for us.
> But we will try to implement the libata driver as needed.
> 
> This patch set is intended to be merged to 2.6.20.
> If you have any comment, please write to me.

Care to post libata version (even if it's not complete)?  Let's work 
something out.

-- 
tejun
