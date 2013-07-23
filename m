Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Jul 2013 23:38:51 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc/8xx: Remove last traces of 8XX_MINIMAL_FPEMU
Message-ID: <20130723133851.GD31944@concordia>
References: <1373964998.2591.57.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373964998.2591.57.camel@x61.thuisdomein>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 16, 2013 at 10:56:38AM +0200, Paul Bolle wrote:
> The Kconfig symbol 8XX_MINIMAL_FPEMU was removed in commit 968219fa33
> ("powerpc/8xx: Remove 8xx specific "minimal FPU emulation""). But that
> commit didn't remove all code depending on that symbol. Do so now.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Not even compile tested!

Help yourself to a cross compiler :)

https://www.kernel.org/pub/tools/crosstool/


cheers
