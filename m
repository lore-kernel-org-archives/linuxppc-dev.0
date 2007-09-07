Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 3A826DDE45
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 18:50:11 +1000 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id l878o9J1022114
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 17:50:09 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail3.sony.co.jp (R8/Sony) with SMTP id l878o8qF022094
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 17:50:08 +0900 (JST)
Message-ID: <46E1108B.30300@am.sony.com>
Date: Fri, 07 Sep 2007 01:49:15 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 2.6.23] PS3: Ignore storage devices that are still being
	probed
References: <Pine.LNX.4.62.0709061813090.22591@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0709061813090.22591@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> PS3: A storage device may show up in the repository before the hypervisor has
> finished probing:
>   - If its type is not yet known, it shows up as PS3_DEV_TYPE_STOR_DUMMY,
>   - If its regions are being probed, it shows up as having zero regions.
> If any of these happen, consider the device not yet present.  The storage
> probe thread will retry later.
> 
> This fixes the timing-dependent problem where a kernel booted from FLASH ROM
> sometimes cannot find the hard disk.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Paul,

This fixes a problem reported by users, so it would be nice for it to go
in for 2.6.23 if possible.  Sorry for it being so late. 

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
