Return-Path: <stefani@seibold.net>
Received: from www84.your-server.de (www84.your-server.de [213.133.104.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B36B5B6F0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 23:44:39 +1100 (EST)
Subject: Re: [PATCH] fix PPC floating point debug
From: Stefani Seibold <stefani@seibold.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1259319716.2076.3.camel@pasglop>
References: <1259312340.9648.6.camel@wall-e> <1259319716.2076.3.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Fri, 27 Nov 2009 13:44:19 +0100
Message-ID: <1259325859.21806.7.camel@wall-e>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, den 27.11.2009, 22:01 +1100 schrieb Benjamin Herrenschmidt: 
> On Fri, 2009-11-27 at 09:59 +0100, Stefani Seibold wrote:
> > The PPC architecture is unable to debug applications using hardware
> > floating point, because it would not save the floating point registers.
> > 
> > After returning from the debugger, the contents of register was
> > modified. This patch fix this bug.
> 
> I'm not sure what problem you are trying to fix... debugging FP apps
> works just fine afaik. You don't need to flush the FP state into the
> thread when delivering the SIGTRAP. If you have a signal handler, that
> will be done for you by the signal code before laying out the signal
> frame. If you are using ptrace, you should be using the appropriate
> ptrace calls to retrieve the FP state and they should do the right thing
> to.
> 

Aeh... Forget it! Thank you for the support.

Stefani
