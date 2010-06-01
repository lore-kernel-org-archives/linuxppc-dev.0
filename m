Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D87C6B7D12
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Jun 2010 19:32:17 +1000 (EST)
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU
	is not set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2aargndy2.fsf@igel.home>
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
	<m3ljb0tn2l.fsf@hase.home>
	<4C03DB3D.7090007__38063.9078132392$1275321190$gmane$org@suse.de>
	<m2aargndy2.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Jun 2010 19:31:56 +1000
Message-ID: <1275384716.1931.711.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-05-31 at 20:06 +0200, Andreas Schwab wrote:
> Alexander Graf <agraf@suse.de> writes:
> 
> > Mind to send it over so I can take a look at it :)? Getting rid of the
> > task_struct structs lying in the stack is certainly a good idea.
> 
> Still untested, because rc1 does not boot.

Ouch ! What machine ?

Cheers,
Ben.
