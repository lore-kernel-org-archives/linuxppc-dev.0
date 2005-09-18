Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <28EAC1FF-341D-45C3-BA9E-221AE04F6DC1@freescale.com>
References: <20050913203555.GB18639@dmt.cnet>
	<28EAC1FF-341D-45C3-BA9E-221AE04F6DC1@freescale.com>
Content-Type: text/plain
Date: Sun, 18 Sep 2005 11:31:39 +1000
Message-Id: <1127007099.23095.10.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cort@fsmlabs.com,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: __switch_to test-and-branch ALTIVEC specific?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-09-13 at 16:43 -0500, Kumar Gala wrote:
> On Sep 13, 2005, at 3:35 PM, Marcelo Tosatti wrote:
> 
> > On Tue, Sep 13, 2005 at 02:05:57PM -0500, Kumar Gala wrote:
> >
> >> This probably has to due with what happens on a G4 system with a
> >> kernel not build with Altivec.. However, I dont remember exactly what
> >>
> >
> >
> >> behavior is desired.
> >>
> >
> > What would be the appropriate set of definitions to use, then ?
> >
> > #if defined (CONFIG_ALTIVEC || CONFIG_6xx) ?
> 
> That's probably better.  Hopefully Ben will have some reason if what  
> you suggest is not sufficient.

Just #ifdef CONFIG_ALTIVEC is fine

Ben.
