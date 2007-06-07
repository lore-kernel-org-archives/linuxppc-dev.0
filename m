Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3F468DDEE0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 11:33:14 +1000 (EST)
Message-ID: <46676051.5010603@am.sony.com>
Date: Wed, 06 Jun 2007 18:33:05 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 08/18] PS3: Kexec support
References: <20070606024407.786638029@am.sony.com>	<4666233F.1080103@am.sony.com>	<1181102510.5536.15.camel@concordia.ozlabs.ibm.com>	<46672D34.8010808@am.sony.com>
	<20070607112541.5a296cd1.sfr@canb.auug.org.au>
In-Reply-To: <20070607112541.5a296cd1.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Geoff,
> 
> On Wed, 06 Jun 2007 14:55:00 -0700 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
>>
>> Michael Ellerman wrote:
>> > On Tue, 2007-06-05 at 20:00 -0700, Geoff Levand wrote:
>> >> Fixup the core platform parts needed for kexec to work on the PS3.
>> >>  - Setup ps3_hpte_clear correctly.
>> >>  - Mask interrupts on irq removal.
>> >>  - Release all hypervisor resources.
>> > 
>> > The irq changes might be kexec related, but it's a mess to review. You
>> > seem to moving a bunch of code around in the patch as well.
>> 
>> Yes, I need to move the static chip_mask routines up so they would be
>> defined before the irq setup/destroy routines.
> 
> I think Michael's point then is that if you submitted a separate
> preceding patch that just moves stuff around without any other changes
> (if at all possible) then reviewing the changes in this would be much
> easier (and our confidence would be higher).

Yes, sorry, I understood.  I've already split it up for the next round.

-Geoff
