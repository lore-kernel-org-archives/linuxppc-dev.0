Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9417B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 08:05:21 +1000 (EST)
Date: Tue, 14 Sep 2010 15:04:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH v2 01/10] RapidIO: Fix RapidIO sysfs hierarchy
Message-Id: <20100914150429.6256b311.akpm@linux-foundation.org>
In-Reply-To: <1284476363-1677-2-git-send-email-alexandre.bounine@idt.com>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com>
	<1284476363-1677-2-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Sep 2010 10:59:14 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Make RapidIO devices appear in /sys/devices/rapidio directory instead of top
> of /sys/devices directory.

Non-backward compatible change?  What is the risk of breaking existing
setups with this change?
