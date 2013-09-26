Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97B962C0334
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 18:01:53 +1000 (EST)
Message-ID: <1380182487.28561.22.camel@pasglop>
Subject: Re: [PATCH 2/3] hwrng: Add a driver for the hwrng found in power7+
 systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 26 Sep 2013 18:01:27 +1000
In-Reply-To: <1380177066-3835-2-git-send-email-michael@ellerman.id.au>
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-2-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tytso@mit.edu, kvm@vger.kernel.org, gleb@redhat.com,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 agraf@suse.de, herbert@gondor.hengli.com.au, Paul Mackerras <paulus@samba.org>,
 mpm@selenic.com, pbonzini@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-26 at 16:31 +1000, Michael Ellerman wrote:

> +       pr_info("registered powernv hwrng.\n");

First letter of a line should get a capital :-) Also since
it's per-device, at least indicate the OF path or the chip number or
something ...

Cheers,
Ben.
