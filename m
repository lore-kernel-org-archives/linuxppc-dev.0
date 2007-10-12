Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FBFADE04B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 10:21:18 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Implement logging of unhandled signals
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071012002007.GA18188@lixom.net>
References: <20071001203242.GA14091@lixom.net>
	<20071002053512.GA21414@lixom.net> <20071012002007.GA18188@lixom.net>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 10:21:09 +1000
Message-Id: <1192148469.8476.64.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-11 at 19:20 -0500, Olof Johansson wrote:
> Implement show_unhandled_signals sysctl + support to print when a process
> is killed due to unhandled signals just as i386 and x86_64 does.
> 
> Default to having it off, unlike x86 that defaults on.

Why ? I'd like it on by default :-)

Ben.
