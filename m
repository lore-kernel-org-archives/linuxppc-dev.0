Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB4D4B712B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 04:51:26 +1100 (EST)
Received: by iwb12 with SMTP id 12so4785153iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 09:51:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
Date: Mon, 24 Jan 2011 11:51:23 -0600
Message-ID: <AANLkTinOz+5YAGzuB_SYAAoX2oYq92FJDc0qw90KL=4z@mail.gmail.com>
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

I've never done any real kernel debugging. Can anyone give any
pointers on how to do early boot debugging on an old world (buggy OF)
powermac? Can I do anything using a serial console?

A little reading last night suggested that spinlocks are supposed to
disappear for single processor machines. I do not understand why they
are present in 3.4.6 (at least the symbol anyway)? The 'acct_lock'
spin lock was also missing with gcc 4.2.4.

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
