Subject: Re: Problems with 2_4_devel & MVME2600 serial interrupts
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1034957059.8253.110.camel@granite.austin.ibm.com>
References: <E9EEC3C2-E2B0-11D6-8132-0003931C2BFA@control.lth.se>
	<1034957059.8253.110.camel@granite.austin.ibm.com>
Date: 18 Oct 2002 14:33:06 -0500
Message-Id: <1034969590.8254.124.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-10-18 at 11:04, Hollis Blanchard wrote:
>
> On Fri, 2002-10-18 at 10:47, Anders Blomdell wrote:
> > > Seems to me that either:
> > > a) the pci_intack value is incorrect for your board, in which case you
> > > should correct it
> > Shure is, question is if it really should be caught from the pci_intack
> > register,
>
> If possible, yes it should (IMHO). There was a thread on linuxppc-dev
> about a year ago:
> http://lists.linuxppc.org/linuxppc-dev/200112/msg00032.html

Oops, this is the right thread:
http://lists.linuxppc.org/linuxppc-dev/200111/msg00073.html

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
