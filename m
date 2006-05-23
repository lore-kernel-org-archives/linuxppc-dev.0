Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 7685F67B26
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 09:03:46 +1000 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by gretel.pobox.com (Postfix) with ESMTP id C4FAE2A30584
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 18:51:47 -0400 (EDT)
Date: Tue, 23 May 2006 17:51:13 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: CPU 1 refused to die!
Message-ID: <20060523225113.GD11414@localdomain>
References: <20060523235819.473e4149.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060523235819.473e4149.pochini@shiny.it>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini wrote:
> 
> I booted with maxcpus=1, then I enabled the 2nd cpu
> with echo 1 > /sys/devices/system/cpu/cpu1/online

So onlining at runtime seems to work.  Did you verify that tasks get
run on the 2nd cpu after you online it?  Any other strange messages in
dmesg?

> I can't disable it anymore. dmesg says "CPU 1 refused to die!".

But offlining doesn't.

Can you online and offline cpus if you boot without maxcpus=1?
