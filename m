Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 7691E68564
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Oct 2005 07:42:20 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 14 Oct 2005 14:42:17 -0700
To: Sven Luther <sl@bplan-gmbh.de>
Message-ID: <20051014214217.GA29529@xyzzy.farnsworth.org>
References: <1129233624.4161.30.camel@localhost.localdomain>
	<20051014135641.15104.qmail@xyzzy.farnsworth.org>
	<20051014151830.GA31442@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051014151830.GA31442@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14-rc3 1/1] chrp_pegasos_eth: Added Marvell
	Discovery II SRAM support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 14, 2005 at 05:18:30PM +0200, Sven Luther wrote:
> On Fri, Oct 14, 2005 at 01:56:41PM -0000, Dale Farnsworth wrote:
> > > -	static struct pci_device_id pci_marvell_mv64360[] = {
> > > +	static struct pci_device_id pci_marvell_mv64360[] =
> > > +	{
> > 
> > > +	if (pci_dev_present(pci_marvell_mv64360))
> > > +	{
> > 
> > Open brace should not be on a line by itself except in function definitions.
> 
> Oh, neat, i knew i should not use same-line-braces for function but didn't
> know i should use them for non-functions :)

???

I guess what I wrote wasn't clear, since in his most recent patch,
Nicolas added more places like the above where the "{" has been moved
to a line by itself.  Just the opposite of what I meant to suggest.

>From Documentation/CodingStyle:
>		Chapter 3: Placing Braces
>
>The other issue that always comes up in C styling is the placement of
>braces.  Unlike the indent size, there are few technical reasons to
>choose one placement strategy over the other, but the preferred way, as
>shown to us by the prophets Kernighan and Ritchie, is to put the opening
>brace last on the line, and put the closing brace first, thusly:
>
>	if (x is true) {
>		we do y
>	}
>
>However, there is one special case, namely functions: they have the
>opening brace at the beginning of the next line, thus:
>
>	int function(int x)
>	{
>		body of function
>	}

-Dale
