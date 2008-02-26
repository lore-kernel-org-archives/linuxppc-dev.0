Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 3AA7DDDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 21:34:30 +1100 (EST)
Date: Tue, 26 Feb 2008 11:34:28 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
Message-ID: <20080226103428.GA2849@netgate.macqel>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
	<08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
	<20080223092458.GA6873@10.1.86.20>
	<1203760269.13162.11.camel@johannes.berg>
	<20080223101707.GA7194@10.1.86.20>
	<1203762305.13162.17.camel@johannes.berg>
	<8B0E09C7-BA68-4994-9AB6-36F400F65832@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8B0E09C7-BA68-4994-9AB6-36F400F65832@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

On Tue, Feb 26, 2008 at 01:39:20AM -0600, Kumar Gala wrote:
>
> On Feb 23, 2008, at 4:25 AM, Johannes Berg wrote:
>
>>
>>> But as I said in the same mail, processes still dies unexpectedly.
>>
>> Yeah, no idea though. I guess you could try putting that into the
>> arch/ppc Makefile, but arch/ppc will be removed this year so you don't
>> want to rely on it.
>
> Its been removed (or will be for 2.6.25).
>
> What compiler version are you using?

a gcc-4.2.1 derivative from codesourcery (4.2-50) that I needed to compile
eglibc for e500 and that I tweaked to use it with CLFS and that I compiled
with --host=powerpc-linuxspe.  I now noticed that it still generates
spe insn's even when given '-mno-spe'.

I am now busy to retest with a vanilla powerpc-linuxspe-gcc-4.2.2 and
that seems to work fine.  I don't think, though, that it is able to compile
eglibc for e500.

Thanks for the attention, and sorry for the noise.

Philippe
