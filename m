Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 515AFB7D24
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Apr 2010 17:25:07 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc: Add form 1 NUMA affinity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100430043407.GC4622@kryten>
References: <20100430043324.GB4622@kryten>  <20100430043407.GC4622@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Apr 2010 17:24:59 +1000
Message-ID: <1272612299.13814.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-04-30 at 14:34 +1000, Anton Blanchard wrote:
> Firmware changed the way it represents memory and cpu affinity on POWER7.
> Unfortunately the old method now caps the topology to work around issues
> with legacy operating systems. For Linux to get the correct topology we
> need to use the new form 1 affinity information.
> 
> We set the form 1 field in the client architecture, and if we see "1" in the
> ibm,associativity-form property firmware supports form 1 affinity and
> we should look at the first field in the ibm,associativity-reference-points
> array. If not we use the second field as we always have.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---

I sent your previous version of that one to Linus, it's already up. Can
you check it's allright ?

Cheers,
Ben.
