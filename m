Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8979BDE21D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 08:57:53 +1100 (EST)
Message-ID: <47A0F2A6.9090908@am.sony.com>
Date: Wed, 30 Jan 2008 13:56:54 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [powerpc changes] Re: x86/non-x86: percpu, node ids, apic ids
	x86.git fixup
References: <200801301414.m0UEEgCC006371@hera.kernel.org>	<Pine.LNX.4.64.0801301622460.11859@vixen.sonytel.be>	<47A09F8A.3000309@sgi.com>
	<20080130161036.GA12293@elte.hu>	<1FE6DD409037234FAB833C420AA843EC757C72@orsmsx424.amr.corp.intel.com>	<20080130180623.GA24881@elte.hu>	<1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>	<20080130184920.GA32212@elte.hu>
	<20080130191302.GA20008@lixom.net> <20080130212558.GA12409@elte.hu>
In-Reply-To: <20080130212558.GA12409@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sparclinux@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
	linux-ia64@vger.kernel.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@samba.org>, anton@samba.org,
	Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar wrote:
> * Olof Johansson <olof@lixom.net> wrote:
> 
>> > could you try the full patchset that Travis has just sent and which 
>> > i've put into x86.git, you can pull it from:
>> 
>> Looks ok for powerpc so far, I haven't gotten through all defconfigs 
>> yet but the first ones that failed before build now. pasemi_defconfig 
>> boots as well.
> 
> could the PowerPC maintainers please Ack the following patch (attached 
> below):
> 
>   Subject: POWERPC: use generic per cpu
>   From: travis@sgi.com
> 
> so that we can push this fix upstream ASAP?
> 
> 	Ingo
> 
> --------------->
> Subject: POWERPC: use generic per cpu
> From: travis@sgi.com
> 
> Powerpc has a way to determine the address of the per cpu area of the
> currently executing processor via the paca and the array of per cpu
> offsets is avoided by looking up the per cpu area from the remote
> paca's (copying x86_64).
> 
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Mike Travis <travis@sgi.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  include/asm-powerpc/percpu.h |   22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)

Tested on PS3 with ps3_defconfig and works OK.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
