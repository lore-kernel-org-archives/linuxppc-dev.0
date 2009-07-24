Return-Path: <stef.simoens@numericable.be>
Received: from smtp11.tech.numericable.fr (smtp11.tech.numericable.fr
	[82.216.111.47])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8B025B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 21:55:20 +1000 (EST)
Received: from smtp4.tech.numericable.fr (smtp4.nc.sdv.fr [10.0.0.60])
	by smtp11.tech.numericable.fr (Postfix) with ESMTP id 347D019F5B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 13:25:36 +0200 (CEST)
Message-ID: <7704005f23c1dfcbfdc8f1963b290d98.squirrel@www.loft5.bisse17-21.be>
In-Reply-To: <1248425553.25467.20.camel@pasglop>
References: <4A68E1CE.4040307@scarlet.be> <1248425553.25467.20.camel@pasglop>
Subject: Re: BUG in dma-mapping.h:218 // MESH SCSI driver not working
From: "Stef Simoens" <stef.simoens@numericable.be>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Date: Fri, 24 Jul 2009 11:55:21 -0000

Hello Ben,

Thank you for your reply.

> On Fri, 2009-07-24 at 00:18 +0200, Stef Simoens wrote:
>> I tried the latest 2.6.31-rc3-git3 (without any other patch).
>> However, I have the same behaviour as the patched 2.6.30 (so: no BUG,
>> but the mesh_abort messages).
> Would it be possible for you to roughly find out at what kernel version
> it stopped working ? (Some kernels may need my patch to avoid crashing)

I am currently running 2.6.29-gentoo-r5 (that's somewhere at the end of
2.6.29, probably 2.6.29.5).

I compiled 2.6.30 as soon as it came 'stable'.
In any version of 2.6.30,  I encounter the BUG (dma-mapping.h:218).

I didn't react immediately, I actually guessed that the problem would have
been reported and solved in another 2.6.30.x.
Because it didn't, I started browsing the mailing-list (and found your
patch).
2.6.30-gentoo-r3 with your patch applied doesn't give the bug,
but gives the mesh_abort.

Before asking the question, I wanted to build the latest 2.6.31-rc
available to make sure my problem didn't get solved in the meantime.
2.6.31-rc3 gives the same mesh_abort.

Would you like me to try all the linux-2.6.30-rc?
Could you give me your best guess starting-point?

I know that there exists something as git-disect ... but I have never used
git (there always needs to be the first time, of course).

Kind regards,

Stef
