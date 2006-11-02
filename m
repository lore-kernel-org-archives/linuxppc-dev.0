Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add of_platform support for OHCI/Bigendian HC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061101234956.GU6360@austin.ibm.com>
References: <45490407.1010700@bplan-gmbh.de>
	<1162419799.25682.466.camel@localhost.localdomain>
	<20061101234956.GU6360@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:07:14 +1100
Message-Id: <1162426034.25682.491.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-01 at 17:49 -0600, Linas Vepstas wrote:
> On Thu, Nov 02, 2006 at 09:23:18AM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2006-11-01 at 21:31 +0100, Nicolas DET wrote:
> > 
> > > +/**+	ohci = hcd_to_ohci(hcd);
>      ^^^
>      ???
> 
> Qu'est que c'est?

Probably just me not properly cutting the previous lines :)

Ben.
