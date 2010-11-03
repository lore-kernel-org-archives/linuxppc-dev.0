Return-Path: <anton@samba.org>
Date: Thu, 4 Nov 2010 00:34:44 +1100
From: Anton Blanchard <anton@samba.org>
To: Patrick Finnegan <pat@computer-refuge.org>
Subject: Re: Problem with Infiniband adapter on IBM p550
Message-ID: <20101104003444.5fff5935@kryten>
In-Reply-To: <201011022315.04291.pat@computer-refuge.org>
References: <201010072324.33062.pat@computer-refuge.org>
	<1286516470.2463.403.camel@pasglop>
	<1286516749.2463.408.camel@pasglop>
	<201011022315.04291.pat@computer-refuge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> > Now, I think this is the problem.
> > 
> > The "assigned-addresses" property seems to indicate that the
> > firmware only assigned BAR 4 and didn't assign anything to the
> > other ones.
> > 
> > I don't know why, but it definitely looks like a firmware bug to me.
> > On those machines, PCI resource assignment is under hypervisor
> > control and so Linux cannot re-assign missing resources itself.
> > 
> > I'll see if I can find a FW person to shed some light on this.
> > 
> > Can you provide me (privately maybe) with the FW version on the
> > machine ?
> 
> Ben,
> 
> Have you found out anything more on this (firmware) bug?

Firmware has the concept of "super slots" which allow larger memory
windows and TCE tables. Section 3.4.3 explains it:

http://www.redbooks.ibm.com/redpapers/pdfs/redp4095.pdf

Anton
