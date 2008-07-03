Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 6D7B8DDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 22:22:19 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so209223yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 05:22:18 -0700 (PDT)
Message-ID: <9e4733910807030522h1aa0bl1801ecc5fc877c25@mail.gmail.com>
Date: Thu, 3 Jul 2008 08:22:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: linux-next: manual merge of the powerpc tree
In-Reply-To: <20080703054739.GA643@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080703133905.7b6f058f.sfr@canb.auug.org.au>
	<20080703054739.GA643@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Jean Delvare <khali@linux-fr.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/3/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Jul 03, 2008 at 01:39:05PM +1000, Stephen Rothwell wrote:
>  > Hi Paul,
>  >
>  > Today's linux-next merge of the powerpc tree got a conflict in
>  > arch/powerpc/sysdev/fsl_soc.c between commit
>  > 4eac6a8b17ce5ebe66eb94b6a0b43aa3a2bf7ea6 ("i2c-mpc: Convert to an
>  > of_platform driver") from the i2c tree and commits
>
>
> It probably would have been better for this patch to go in via the
>  PowerPC tree.  It only touches powerpc-specific i2c code, not any i2c
>  core code.  There are quite a few MPCxxxx ports which use this driver,
>  I'd be happier to see it dropped from the i2c tree and merged in via
>  either Kumar or myself.
>
>  I'd also like to see some acks from people who have tested this patch
>  before it goes in.  (I'm just as guilty here; I'll apply it and test it
>  to my tree tomorrow).

I'm using it in my system. It doesn't change the function of the i2c
controller, only how drivers get loaded. So if you boot and your
devices are there it is working.

Testing was good when the patch was initially posted in January. In
the last six months the initial patch set has been sliced and diced
into a bunch of different pieces but the contents of this patch are
essentially unchanged.

I don't care which tree it uses to get to mainline, I'd just like to
see it get merged.


>
>
>  g.
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
