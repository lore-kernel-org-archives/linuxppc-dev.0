Date: Thu, 8 Jul 2004 16:59:33 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibm_ocp ethernet OPB clocks
Message-ID: <20040708165933.A11407@home.com>
References: <40EDC59E.9020403@rossvideo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40EDC59E.9020403@rossvideo.com>; from rsiemsen@rossvideo.com on Thu, Jul 08, 2004 at 06:07:26PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 08, 2004 at 06:07:26PM -0400, Ralph Siemsen wrote:
>
> In pretty much all versions of the kernel (I checked 2.4.x, 2.6.7), one
> finds in drivers/net/ibm_ocp/ibm_ocp_emac.h:
>
> #define EMAC_M1_OPB_CLK_66              0x00000010      /* 66Mhz */
> #define EMAC_M1_OPB_CLK_83              0x00000008      /* 83hz */
>
> I believe these bitfield values are reversed... at least according to
> the 440GX usermanual, page 879.  Bug/typo?  Is the usermanual wrong?  Or
> perhaps other 4xx series processors have different definitions?
>
> The definitions for 100MHz and >100MHz appear to be correct though.

I doublechecked that these didn't creep back in since I was sure I
fixed them.  In 2.6.7 there is no drivers/net/ibm_ocp/ibm_ocp_emac.h
That driver has never been in kernel.org 2.6.7.  I've just removed
it in linuxppc-2.5, since it's been deprecated by the new EMAC
driver.  The corrected values are in there.  Same goes for current
2.4. Try a current kernel.

> Is there a current maintainer for this driver?

That's me, now.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
