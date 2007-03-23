Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id BB1B8DE0C0
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 02:21:35 +1100 (EST)
Message-ID: <4603F077.9090905@smiths-aerospace.com>
Date: Fri, 23 Mar 2007 11:21:27 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Remove bogus errors from check_chosen.
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>	<20070323033158.GG28006@localhost.localdomain>
	<20070323150517.GB6060@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070323150517.GB6060@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Fri, Mar 23, 2007 at 02:31:58PM +1100, David Gibson wrote:
>> I'm not 100% comfortable with this patch; I'd like for dtc to have the
>> facility to do more-or-less complete tree validation.
> 
> That'd be nice as long as it's optional; it should be possible to do a
> low level dts->dtb transformation without the tool assuming that the
> output is intended to be a final, valid tree with the specific bindings
> that dtc knowns about (or even an OF-ish tree at all).
> 
> -Scott

It needs a -Wall ;-)

The -q[q[q]] I added cuts down/eliminates the moaning, but you still 
have to -f force the output which doesn't match what Scott is advocating 
if I understand him.

The gcc -Wall is backwards to what we should have, perhaps adding --no* 
options like:
   --nochosen
   --nocpu
   --noarmyboots
to tell dtc that lonely barefoot blobs are OK.

gvb
