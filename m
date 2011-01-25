Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82B44B7129
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 15:01:21 +1100 (EST)
Received: by iye19 with SMTP id 19so5319313iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 20:01:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
Date: Mon, 24 Jan 2011 22:01:18 -0600
Message-ID: <AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
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

4.2.4 does NOT work.

4.1.2 DOES work.

Is there some magic PowerPC specific gcc patch somewhere? Should I
reorient the computer relative to the planet's magnetic field when I
compile with newer gcc? A magic handshake? what?

Is anyone using a compiler newer than 4.1.2?

Sorry, but I do not know where to go from here?

kevin

On Sat, Jan 22, 2011 at 12:24 PM, kevin diggs <diggskevin38@gmail.com> wrote:
> Hi,
>
> If I enable SMP then I can build a 2.6.28 kernel with gcc 4.3.5 that
> WILL boot on the PowerMac8600 (single 750GX). The previously mentioned
> G4 that runs is a dual cpu beast and thus also runs SMP.
>
> I at least know this (ok, I THINK I know):
>
> For non-SMP:  The spinlock 'acct_lock' in kernel/acct.c that IS
> present in 3.4.6 (i.e. kernel 2.6.28 compiled with gcc 3.4.6). Not so
> much for 4.3.5. I have not yet done a general 4.3.5 compiled 2.6.28
> spinlock safari.
>
> Don't some funky, optimizery things happen to spinlocks for the NON-smp case?
>
> I'll see what the 4.2.x gcc does.
>
> Thanks!
>
> kevin
>
> P.S.:  There is one other difference for the SMP 4.3.5 compiled
> 2.6.28:  my 750gx cpufreq driver gets disabled. It is fairly isolated
> code though. Should not be able to nuke the spinlock in kernel/acct.c
>
> On Fri, Jan 21, 2011 at 1:26 PM, kevin diggs <diggskevin38@gmail.com> wrote:
>> Hi,
>>
>> Anyone familiar with BootX? Could my problems with the 8600 be related
>> to some interaction with BootX?
>>
>> kevin
>>
>
