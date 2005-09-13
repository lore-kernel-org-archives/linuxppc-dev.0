Return-Path: <marcelo.tosatti@cyclades.com>
Date: Tue, 13 Sep 2005 17:35:55 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050913203555.GB18639@dmt.cnet>
References: <20050913175028.GB14889@dmt.cnet>
	<A6CA30D6-DDC3-4AEF-8CA2-58CFA261F44B@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A6CA30D6-DDC3-4AEF-8CA2-58CFA261F44B@freescale.com>
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

On Tue, Sep 13, 2005 at 02:05:57PM -0500, Kumar Gala wrote:
> This probably has to due with what happens on a G4 system with a  
> kernel not build with Altivec.. However, I dont remember exactly what  
> behavior is desired.

What would be the appropriate set of definitions to use, then ? 

#if defined (CONFIG_ALTIVEC || CONFIG_6xx) ?
