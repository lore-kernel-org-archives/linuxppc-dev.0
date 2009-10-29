Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2A8BB7BEF
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 14:28:10 +1100 (EST)
Subject: Re: [PATCH 6/6 v5] CPU DLPAR Handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4AE8B0B1.4020102@austin.ibm.com>
References: <4AE8ADCF.6090104@austin.ibm.com> <4AE8B0B1.4020102@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Oct 2009 14:26:03 +1100
Message-ID: <1256786763.26770.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-28 at 15:59 -0500, Nathan Fontenot wrote:

> +#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
> +static ssize_t cpu_probe(const char *buf, size_t count)

dlpar_cpu_probe() pls

> +static ssize_t cpu_release(const char *buf, size_t count)
> +{

Ditto.

Or else in system.map, backtraces, etc... it's hard to figure out off
hand where it's dying :-)

Cheers,
Ben.
