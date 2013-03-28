Return-Path: <michael@ellerman.id.au>
Date: Thu, 28 Mar 2013 11:31:56 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc: drop even more unused Kconfig symbols
Message-ID: <20130328003156.GA8130@concordia>
References: <1363864206.1390.117.camel@x61.thuisdomein>
 <1364381495.1345.21.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364381495.1345.21.camel@x61.thuisdomein>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 27, 2013 at 11:51:35AM +0100, Paul Bolle wrote:
> On Thu, 2013-03-21 at 12:10 +0100, Paul Bolle wrote:
> > diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
> > index 79d2225..9eea710 100644
> > --- a/arch/powerpc/platforms/wsp/Kconfig
> > +++ b/arch/powerpc/platforms/wsp/Kconfig
> > @@ -29,7 +29,3 @@ config PPC_CHROMA
> >  	default y
> >  
> >  endmenu
> > -
> > -config PPC_A2_DD2
> > -	bool "Support for DD2 based A2/WSP systems"
> > -	depends on PPC_A2
> 
> This part was not included in the "powerpc: remove PReP" follow up
> patch. Should I resend separately?

Yes thanks.

It was added in commit a1d0d98 "Add WSP platform" but should not have
been, it was to support bringup hacks that were never merged upstream.

cheers
