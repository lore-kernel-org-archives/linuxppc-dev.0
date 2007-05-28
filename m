Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 7DB0BDDEF0
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 18:46:58 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 28 May 2007 10:46:52 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Porting "prep" from ppc to powerpc.
Message-ID: <20070528084652.GA7686@iram.es>
References: <200705252238.39819.rob@landley.net>
	<20070528075507.GA6633@iram.es>
	<1180340614.19517.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180340614.19517.68.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 28, 2007 at 06:23:34PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-05-28 at 09:55 +0200, Gabriel Paubert wrote:
> > I was thinking of writing a bootwrapper that would
> > convert residual data to flat device tree. There
> > is a lot of valuable information in the residual data,
> > like the interrupt routing (which is correct if you 
> > can read the spec, which is not what the code in
> > arch/ppc did). 
> 
> We were wondering the other day how reliable the residual data are...
> 

On the boards I use, they are very good. And there is some information
(memory size, tb and cpu freq, etc...) that I'd rather take from the 
residual data than trying to guess.

> David Gibson's been toying with that too already, you should sync with
> him. 

I've not yet started to write anything (finishing a hardware project).

	Regards,
	Gabriel
