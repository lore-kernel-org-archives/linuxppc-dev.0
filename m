Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2582B70EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 06:36:47 +1100 (EST)
Received: by iye19 with SMTP id 19so307314iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 02 Feb 2011 11:36:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
	<AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
Date: Wed, 2 Feb 2011 13:36:44 -0600
Message-ID: <AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
Subject: Re: BootX
From: kevin diggs <diggskevin38@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
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

FYI:

I have narrowed this down to drivers/scsi/mesh.c (the root disk
controller for the PowerMac 8600). I have compiled everything else for
2.6.36 with 4.3.5, including modules. With a 4.1.2 compiled mesh.c the
beast boots. I am using it to post this follow up.

kevin

> On Sat, Jan 22, 2011 at 12:24 PM, kevin diggs <diggskevin38@gmail.com> wrote:
>> Hi,
>>
>> If I enable SMP then I can build a 2.6.28 kernel with gcc 4.3.5 that
>> WILL boot on the PowerMac8600 (single 750GX). The previously mentioned
>> G4 that runs is a dual cpu beast and thus also runs SMP.
>>
