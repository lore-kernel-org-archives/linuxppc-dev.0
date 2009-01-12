Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 4913F474FB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 10:01:32 +1100 (EST)
Message-ID: <496BCBAC.7070307@am.sony.com>
Date: Mon, 12 Jan 2009 15:01:00 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: submitted patches
References: <2f26be4be72081b3c5b33101b439c368@bga.com>
In-Reply-To: <2f26be4be72081b3c5b33101b439c368@bga.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> I request the following patches in patchwork be considered for 2.6.29:
> 
> http://patchwork.ozlabs.org/patch/3778/
> powerpc ps3: use smp_request_message_ipi

I tested this on PS3, and it seems to work OK.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
