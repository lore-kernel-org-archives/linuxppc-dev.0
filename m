Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2AE0B72B1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 06:39:40 +1100 (EST)
Received: by iwn3 with SMTP id 3so4316767iwn.15
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2011 11:39:37 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 23 Feb 2011 13:39:37 -0600
Message-ID: <AANLkTinz=CrCTEeAPQjE8B=yjQx+WLs_FKj2u+0-JeAS@mail.gmail.com>
Subject: rtc on PowerMac7,3
From: kevin diggs <diggskevin38@gmail.com>
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Sorry for the noise.

How do I access the rtc on a PowerMac7,3 (dual 2.5 GHz 970FX) using
2.6.36? rtc-generic does not seem to work. It will work on my 8600. I
do see this:

[   15.014542] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0

Is it the hwclock binary:

hwclock from util-linux-2.13-pre7

I think I could get this to work in 2.6.28 using rtc-ppc.

Thanks!

kevin
