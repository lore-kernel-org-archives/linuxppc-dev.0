Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 6FB17DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 15:47:43 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so716705wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 22:47:41 -0700 (PDT)
Date: Wed, 2 Jul 2008 23:47:39 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Rothwell <sfr@canb.auug.org.au>, jonsmirl@gmail.com,
	galak@kernel.crashing.org
Subject: Re: linux-next: manual merge of the powerpc tree
Message-ID: <20080703054739.GA643@secretlab.ca>
References: <20080703133905.7b6f058f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080703133905.7b6f058f.sfr@canb.auug.org.au>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 01:39:05PM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> Today's linux-next merge of the powerpc tree got a conflict in
> arch/powerpc/sysdev/fsl_soc.c between commit
> 4eac6a8b17ce5ebe66eb94b6a0b43aa3a2bf7ea6 ("i2c-mpc: Convert to an
> of_platform driver") from the i2c tree and commits

It probably would have been better for this patch to go in via the
PowerPC tree.  It only touches powerpc-specific i2c code, not any i2c
core code.  There are quite a few MPCxxxx ports which use this driver,
I'd be happier to see it dropped from the i2c tree and merged in via
either Kumar or myself.

I'd also like to see some acks from people who have tested this patch
before it goes in.  (I'm just as guilty here; I'll apply it and test it
to my tree tomorrow).

g.
