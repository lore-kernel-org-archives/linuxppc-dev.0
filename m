Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id B79C8DDF43
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 00:20:08 +1000 (EST)
Date: Thu, 8 May 2008 18:20:05 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC PATCH 0/3] Board-specific PCI fixups [was: Re: [PATCH 2/2]
	[POWERPC] 86xx: mpc8610_hpcd: add support for ULI RTC]
Message-ID: <20080508142005.GA6749@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 05, 2008 at 02:11:30PM -0500, Kumar Gala wrote:
>
> On May 5, 2008, at 1:56 PM, Anton Vorontsov wrote:
>
>> The ULI "Super South Bridge" contains ISA bridge to the legacy
>> devices, such as Super IO mouse/keyboard/floppy disk controllers,
>> parallel port, i8259 interrupt controller and so on.
>>
>> On the MPC8610HPCD, i8259 seems to be disabled (mpc8610_hpcd.c
>> confirms this), and other peripherals are not traced out.
>> So we use only RTC.
>>
>> This patch also adds ULI quirk to make RTC actually work (this
>> quirk differs a bit from the one in the fsl_uli1575.c).
>
> Can we just one quick for both?

Probably yes, but fsl_uli1575 needs some other changes for this.

This series fully tested on MPC8610HPCD, and build-tested for
MPC85xxDS and MPC8641HPCN.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
