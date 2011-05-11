Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8ACD9B6F4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 06:01:17 +1000 (EST)
Date: Wed, 11 May 2011 13:00:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] RapidIO: Fix default routing initialization
Message-Id: <20110511130024.955f1981.akpm@linux-foundation.org>
In-Reply-To: <1305125163-14590-1-git-send-email-alexandre.bounine@idt.com>
References: <1305125163-14590-1-git-send-email-alexandre.bounine@idt.com>
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

On Wed, 11 May 2011 10:46:03 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Fix switch initialization to ensure that all switches have default
> routing disabled. This guarantees that no unexpected RapidIO packets
> arrive to the default port set by reset and there is no default routing
> destination until it is properly configured by software.
> 
> This update also unifies handling of unmapped destinations by tsi57x,
> IDT Gen1 and IDT Gen2 switches.

The changelog doesn't permit me to determine the importance of this fix,
so I don't know whether to schedule it for 2.6.39 or for -stable.
