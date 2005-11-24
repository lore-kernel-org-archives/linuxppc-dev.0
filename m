Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1132852136.11921.85.camel@baythorne.infradead.org>
References: <1132634960.26560.133.camel@gaston>
	<1132852136.11921.85.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 07:57:13 +1100
Message-Id: <1132865833.26560.453.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: serial port discovery
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-11-24 at 17:08 +0000, David Woodhouse wrote:
> On Tue, 2005-11-22 at 15:49 +1100, Benjamin Herrenschmidt wrote:
> > This moves the discovery of legacy serial ports to a separate file,
> > makes it common to ppc32 and ppc64, and reworks it to use the new OF
> > address translators to get to the ports early. This new version can also
> > detect some PCI serial cards using legacy chips and will probably match
> > those discovered port with the default console choice.
> 
> This makes it deal with the fact that the Pegasos firmware reports that
> its clock frequency is zero...

Gack !?!?

Sven, what's up there ? Why the hell would you do that ?

Ben.
