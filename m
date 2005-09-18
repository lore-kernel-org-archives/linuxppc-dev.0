Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <A6CA30D6-DDC3-4AEF-8CA2-58CFA261F44B@freescale.com>
References: <20050913175028.GB14889@dmt.cnet>
	<A6CA30D6-DDC3-4AEF-8CA2-58CFA261F44B@freescale.com>
Content-Type: text/plain
Date: Sun, 18 Sep 2005 11:31:08 +1000
Message-Id: <1127007069.23095.8.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: __switch_to test-and-branch ALTIVEC specific?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-09-13 at 14:05 -0500, Kumar Gala wrote:
> This probably has to due with what happens on a G4 system with a  
> kernel not build with Altivec.. However, I dont remember exactly what  
> behavior is desired.

No, we should never set MSR_VEC on a kernel not built with
CONFIG_ALTIVEC.

Ben.
