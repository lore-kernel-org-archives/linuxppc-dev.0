Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id BAFE9DE58C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 03:50:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PPC to PowerPC Migration
Date: Wed, 11 Jun 2008 10:52:13 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109603587@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <20080611133247.0ac8b7c6@zod.rchland.ibm.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com><161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net><f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com><D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com><20080611123254.64fabf64@vader.jdub.homelinux.org><D61182AC8012EA4EBC531B3AF23BE109603578@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611133247.0ac8b7c6@zod.rchland.ibm.com>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Josh,

Is there a special git tree for 4xx or are you referring to kernel.org?
... or do I just post the patches to this list?

Regards,

Darcy


--snip!--
> Once I get this done, I can submit BSP patch sets for kernel 2.6.25
and
> 2.6.26.  If there is demand, I could submit a BSP patch set for 2.6.24
> as well.

Preferably, you'd submit to the tip of the git tree for 4xx.  With the
pace of kernel development, releasing patches for "old" kernels just
means that someone has to forward port them to the latest tree.  That
might be a small effort, but in practice it's best to work with
bleeding edge if you're going to submit a patch for inclusion.

Don't be discouraged by that.  There are those that will help you if
you run into obstacles.
--snip!--
