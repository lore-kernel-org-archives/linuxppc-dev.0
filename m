Return-Path: <segher@kernel.crashing.org>
Received: from localhost.localdomain (adsl-63-203-10-66.dsl.lsan03.pacbell.net
	[63.203.10.66]) by ozlabs.org (Postfix) with SMTP id A28142BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 16:46:30 +1000 (EST)
Received: from [172.20.101.118] by localhost.localdomain for
	<linuxppc-embedded@ozlabs.org>; Tue, 28 Sep 2004 06:44:01 -7GMT
In-Reply-To: <20040927233749.E30772@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927231438.D30772@home.com>
	<F80E3944-1116-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927233749.E30772@home.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FB412DE8-1119-11D9-8370-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 28 Sep 2004 01:45:27 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Cc: David Gardiner <daveg@sonartech.com.au>, linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> Sure.  But the interrupt _assignment_ should be done by firmware.
>
> I can't argue with ideaology.

It's not ideology; it's what the PCI spec says.

>> p.s.  And I know this isn't always practically possible; but why
>> then support a product like that at all, in the Open Source
>> community?
>
> By this reasoning, we should also not support the many BIOS/OF
> platforms that report incorrect data and have to have their
> reported data fixed up by the kernel. That's gross too by the
> same measure.

There is a difference between patching some errors and doing
all the work yourself.

But hey, let not me stop you from doing this.
