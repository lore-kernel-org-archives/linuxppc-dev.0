Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 52B091007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 01:31:33 +1100 (EST)
Received: by vbal1 with SMTP id l1so241484vba.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 06:31:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACoXjc=RBpB6eYu1zB-kCcYmsV8rdbzYtdxyBJDLTdt6uu04ig@mail.gmail.com>
References: <1321945877-22802-1-git-send-email-tinamdar@apm.com>
 <CA+5PVA7BD9jNoV9LrXjk2+UPBW8MSTPkwpYPFj2y-CNkXCrAhA@mail.gmail.com>
 <CACoXjc=RBpB6eYu1zB-kCcYmsV8rdbzYtdxyBJDLTdt6uu04ig@mail.gmail.com>
Date: Tue, 22 Nov 2011 09:31:29 -0500
Message-ID: <CA+5PVA6b7Ezo7LsRHX94spkdMabSWGw6q+HJYGsUepY33ArRRw@mail.gmail.com>
Subject: Re: powerpc: dts: Fix canyonlands EMAC interrupt map
From: Josh Boyer <jwboyer@gmail.com>
To: Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2011 at 9:15 AM, Tanmay Inamdar <tinamdar@apm.com> wrote:
>
> On Tue, Nov 22, 2011 at 5:00 PM, Josh Boyer <jwboyer@gmail.com> wrote:
>>
>> On Tue, Nov 22, 2011 at 2:11 AM, Tanmay Inamdar <tinamdar@apm.com> wrote=
:
>> > Fixing interrupt mapping of EMAC for canyonlands
>> >
>> > Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>>
>> As far as I can tell, your changes aren't really changing anything
>> just making it a bit clearer, correct? =A0If so, do you mind if I change
>> the commit log to "clear up" instead of fix?
>
> Actually Rob Herring's commit
> (http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcommi=
t;h=3Ddc9372808412edbc653a675a526c2ee6c0c14a91)
> breaks the interrupt mapping in EMAC driver.
> I am trying to fix this issue by mapping interrupts in different way.

I see.  That should have been in the commit log then.  I'll add
something like that to it.

josh
