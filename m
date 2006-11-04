Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-127.roch.qwest.net [67.41.71.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AEF367BDC
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 03:18:03 +1100 (EST)
Subject: Re: FSL vs. IBM BookE
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1162632114.28571.33.camel@localhost.localdomain>
References: <1162632114.28571.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 10:16:40 -0600
Message-Id: <1162657000.3139.108.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-04 at 20:21 +1100, Benjamin Herrenschmidt wrote:
> Out of curiosity... I noticed we have both head_44x.S and
> head_fsl_booke.S, the later being a fork of the former with changed from
> Kumar (and possibly others) to support E200 and E500.
> 
> How bad are the differences between those cores ? Would it be possible
> to reconcile those and IBM 44x into a single processor family ? Or are
> there some fundamental differences making that impossible ? (even with a
> bit of CPU feature patching).

I'm not sure.  Maybe Kumar knows better since he made the changes to
head_fsl_booke.S.  I believe FSL can do SMP and has an SPE and some
other HID registers that 44x does not have.

> 
> Also, I suppose we should rename head_4xx.S to head_40x.S no ?

That would be fine with me.  I can send a patch if you'd like.

josh
