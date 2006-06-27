Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A38B067A66
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 08:50:18 +1000 (EST)
Subject: Re: Fixed PPC SHA1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux@horizon.com
In-Reply-To: <20060623005456.21460.qmail@science.horizon.com>
References: <20060623005456.21460.qmail@science.horizon.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 08:50:03 +1000
Message-Id: <1151448603.2350.104.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, git@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-22 at 20:54 -0400, linux@horizon.com wrote:
> Here's the lwsi-based version that's slightly faster on a G5, but slightly
> slower on a G4.

I wouldn't bother with 2 versions... use the non-string version (string
operations will cause performance problems on other processors)

Ben.
