Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CA8CB7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 08:46:36 +1100 (EST)
Subject: Re: [PATCH v2 3/3] powerpc: Add IO event interrupt support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1297114832.24377.42.camel@flin.austin.ibm.com>
References: <1294267483.24377.30.camel@flin.austin.ibm.com>
	<1297055437.14982.57.camel@pasglop>
	<1297114832.24377.42.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Feb 2011 08:46:20 +1100
Message-ID: <1297115180.14982.83.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 15:40 -0600, Tseng-Hui (Frank) Lin wrote:
> > We are -really- re-inventing interrupts and/or notifiers here, which
> > I find a tad annoying..
> 
> Agree. This is ugly. We could have just used the regular interrupt
> mechanism if the firmware didn't use shared rtas call and interrupt
> to report multiple types of events.

A notifier wouldn't have worked ?

Cheers,
Ben.
