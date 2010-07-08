Return-Path: <lee.nipper@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 1DA9BB6EF0
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 03:59:32 +1000 (EST)
Received: by gwj19 with SMTP id 19so87792gwj.15
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jul 2010 10:59:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
References: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
Date: Thu, 8 Jul 2010 12:59:29 -0500
Message-ID: <AANLkTikCFgFZsAl0QLkZbI1Jbrh8v0d7gK9EVtqCe1QU@mail.gmail.com>
Subject: Re: 405EX Rev D mis-identification?
From: Lee Nipper <lee.nipper@gmail.com>
To: Marc Chidester <marcchidester@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: lee.nipper@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 8, 2010 at 10:06, Marc Chidester <marcchidester@gmail.com> wrote:
> It looks like the Rev D version of the 405EX chip without security
> will be identified as a 405EXr, based on the values in the cpu_specs
> table.

Yes, that is the case.
The 405EX Rev D without security PVR matches an old 405EXr A/B with security,
and hence the cpu_spec entries' pvr_mask values are no longer correct.

> Is there an algorithm update needed or am I missing something?

Perhaps add more cpu_spec table entries for the 405EX & 405EXr with
pvr_mask = 0xffff000f  ?
