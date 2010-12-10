Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 155C5B70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 10:19:44 +1100 (EST)
Date: Fri, 10 Dec 2010 15:19:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH -mm 0/4] RapidIO: Misc updates
Message-Id: <20101210151924.333afed7.akpm@linux-foundation.org>
In-Reply-To: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
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

On Fri, 10 Dec 2010 15:38:14 -0500
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> The following four patches are follow-up to two RapidIO patches
> that are in the -mm tree now.
> 
> Alexandre Bounine (4):
>   RapidIO: Add definitions of Component Tag fields
>   RapidIO: Add device object linking into discovery
>   RapidIO: Use Component Tag for unified switch identification
>   RapidIO: Add new sysfs attributes
> 

I held
rapidio-use-common-destid-storage-for-endpoints-and-switches.patch and
rapidio-integrate-rio_switch-into-rio_dev.patch back from 2.6.37 due to
ongoing discussion.  What is the situation now?
