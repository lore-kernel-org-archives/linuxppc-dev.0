Message-ID: <40EEF998.3090402@rossvideo.com>
Date: Fri, 09 Jul 2004 16:01:28 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibm_ocp ethernet OPB clocks
References: <40EDC59E.9020403@rossvideo.com> <20040708165933.A11407@home.com>
In-Reply-To: <20040708165933.A11407@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> I doublechecked that these didn't creep back in since I was sure I
> fixed them.  In 2.6.7 there is no drivers/net/ibm_ocp/ibm_ocp_emac.h
> That driver has never been in kernel.org 2.6.7.  I've just removed
> it in linuxppc-2.5, since it's been deprecated by the new EMAC
> driver.  The corrected values are in there.  Same goes for current
> 2.4. Try a current kernel.

Thanks for the feedback... You are right, I was looking at linuxppc-2.5
and not the mainline.  The vanilla 2.6.7 tarball seems to have the right
thing defined in drivers/net/ibm_emac, I presume this is the new
driver... I'll give it a whirl, if I can get it to boot :)

-R

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
