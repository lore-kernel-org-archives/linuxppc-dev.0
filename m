Return-Path: <akpm00@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65C98B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Sep 2011 17:58:31 +1000 (EST)
Received: by iabn5 with SMTP id n5so1086525iab.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Sep 2011 00:58:27 -0700 (PDT)
Date: Thu, 15 Sep 2011 00:58:48 -0700
From: Andrew Morton <akpm00@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] memory hotplug: Refuse to add unaligned memory regions
Message-Id: <20110915005848.59e6fb36.akpm@linux-foundation.org>
In-Reply-To: <20110915062615.782bc4df@kryten>
References: <20110915062615.782bc4df@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Sep 2011 06:26:15 +1000 Anton Blanchard <anton@samba.org> wrote:

> 
> The sysfs memory probe interface allows unaligned regions
> to be added:
> 
> # echo 0xffffff > /sys/devices/system/memory/probe
> 
> # cat /proc/iomem 
> 00ffffff-01fffffe : System RAM
> 01ffffff-02fffffe : System RAM
> 02ffffff-03fffffe : System RAM
> 03ffffff-04fffffe : System RAM
> 04ffffff-05fffffe : System RAM

Then don't do that?
