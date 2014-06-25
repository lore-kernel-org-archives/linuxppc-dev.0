Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D5B61A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 08:24:16 +1000 (EST)
Date: Wed, 25 Jun 2014 23:23:56 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/9] drivers: base: support cpu cache information
 interface to userspace via sysfs
Message-ID: <20140625222355.GK32514@n2100.arm.linux.org.uk>
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-3-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403717444-23559-3-git-send-email-sudeep.holla@arm.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 25, 2014 at 06:30:37PM +0100, Sudeep Holla wrote:
> +		coherency_line_size: the minimum amount of data that gets transferred

So, what value to do envision this taking for a CPU where the cache
line size is 32 bytes, but each cache line has two dirty bits which
allow it to only evict either the upper or lower 16 bytes depending
on which are dirty?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
