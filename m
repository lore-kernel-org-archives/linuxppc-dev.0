Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 041F9B7B9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 15:26:56 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 95F31DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 15:26:55 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	30F9031A7F8
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 07:26:54 +0200 (CEST)
Received: from [192.168.1.6] ([87.97.88.130])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KNK00DC3XST67A0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Thu, 30 Jul 2009 07:26:54 +0200 (CEST)
Date: Thu, 30 Jul 2009 07:31:44 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: 82xx, mgcoge: updates for 2.6.32
In-reply-to: <820BFB98-F940-4B5C-8D4A-9C069B3DC199@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Message-id: <4A713040.3060005@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4A70091E.7000002@denx.de>
	<820BFB98-F940-4B5C-8D4A-9C069B3DC199@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar,

Kumar Gala wrote:
> 
> On Jul 29, 2009, at 3:32 AM, Heiko Schocher wrote:
> 
>> - add I2C support
>> - add FCC1 and FCC2 support
>> - fix bogus gpio numbering in plattformcode
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> - based on git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>>  next branch
>> - checked with checkpatch.pl:
>> $ ./scripts/checkpatch.pl 0001-82xx-mgcoge-updates-for-2.6.32.patch
>> total: 0 errors, 0 warnings, 531 lines checked
>>
>> 0001-82xx-mgcoge-updates-for-2.6.32.patch has no obvious style
>> problems and is ready for submission.
>> $
>>
>> BTW: Who is PPC82XX Maintainer? I couldn;t find such an entry
>>     in the MAINTAINERS file ...
> 
> its me.

Ah, thought it, but I wasn;t sure ... Hmm, maybe you can update
the MAINTAINERS entry?

>> arch/powerpc/boot/dts/mgcoge.dts      |   56 ++++++++++
>> arch/powerpc/configs/mgcoge_defconfig |  178
>> +++++++++++++++++++++++++-------
> 
> Can we hold off or pull the defconfig update into a separate patch.  I
> normally update defconfigs in a late -rc series and that will probably
> generate merge conflicts.

I make a seperate patch for the defconfig.

Thanks. I wait for more comments, before I post the next version
of this patch.
bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
