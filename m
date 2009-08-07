Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ED6FBB7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 15:52:54 +1000 (EST)
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 88479DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 15:52:53 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	7947C11A879
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 07:52:50 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.206.253])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KNZ00DPPSC1OIJ0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Fri, 07 Aug 2009 07:52:50 +0200 (CEST)
Date: Fri, 07 Aug 2009 07:58:21 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 2/2] 82xx, mgcoge: update defconfig for 2.6.32
In-reply-to: <40E28EF5-215D-4D69-B44E-CD3145652F9B@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Message-id: <4A7BC27D.6000002@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4A769326.9090302@denx.de>
	<40E28EF5-215D-4D69-B44E-CD3145652F9B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
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
> On Aug 3, 2009, at 2:35 AM, Heiko Schocher wrote:
> 
>> - add I2C support
>> - add FCC1 and FCC2 support
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> - against git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>>  next branch
>> - checked with checkpatch.pl:
>> $ ./scripts/checkpatch.pl
>> 0002-82xx-mgcoge-update-defconfig-for-2.6.32.patch
>> total: 0 errors, 0 warnings, 381 lines checked
> 
> I had problems applying this to my 'next' branch

Ups, Sorry, I based this patchset against:
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
                                              ^^^^

I make a patch against your next branch ...

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
