Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40804081615n284aa750n12ceb0bf1d1bcce1@mail.gmail.com>
Date: Tue, 8 Apr 2008 17:15:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: ppc440 caches - change proposal [RFC]
In-Reply-To: <1207695415.14711.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080408225329.5EC171A8007D@mail11-dub.bigfish.com>
	<1207695415.14711.11.camel@pasglop>
Cc: John Bonesio <john.bonesio@xilinx.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 8, 2008 at 4:56 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>  On Tue, 2008-04-08 at 15:53 -0700, John Bonesio wrote:
>  > I was thinking it might be good to have the kernel initialize these
>  > cache control registers in it's own start up code. Or perhaps this
>  > could be done in the kernel's simple bootloader. We could probably put
>  > this change in a Xilinx specific startup file, but this change doesn't
>  > seem specific to Xilinx FPGA boards.
>
>  The kernel's wrapper would be a good place to put that I suspect. That's
>  the kind of thing that should be provided as a "library" function to be
>  optionally called by platform code. Either in the wrapper or the main
>  kernel platform code.

Code is already queued up for 2.6.26 to do exactly this on ppc405
virtex platforms.  We can do the same thing for 440.  Look at
virtex405-head.S in the following patch:

http://patchwork.ozlabs.org/linuxppc/patch?person=486&id=17410

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
