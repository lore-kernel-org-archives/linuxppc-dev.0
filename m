Return-Path: <rbeims@gmail.com>
Received: from mail-fx0-f66.google.com (mail-fx0-f66.google.com
	[209.85.161.66]) by ozlabs.org (Postfix) with ESMTP id 5B3F0B70E7
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2011 05:50:19 +1100 (EST)
Received: by fxm14 with SMTP id 14so4658574fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Jan 2011 10:50:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110105183506.07BB815243A@gemini.denx.de>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
	<20110105183506.07BB815243A@gemini.denx.de>
Date: Wed, 5 Jan 2011 16:50:14 -0200
Message-ID: <AANLkTikVbkHW-25jABmJ5YLPcF4kB_wXdhe9W7Ai6Lif@mail.gmail.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
From: Rafael Beims <rbeims@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mr. Denk

As I already posted, the patch that was posted before seems to have
solved the problem. Anyway, some answers follow:

On Wed, Jan 5, 2011 at 4:35 PM, Wolfgang Denk <wd@denx.de> wrote:
>
> Dear Rafael Beims,
>
> In message <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>=
 you wrote:
> >
> > I'm working with an MPC880 board that is supposed to run linux-2.6.32. =
After
> > some work, I could get the kernel up and running, mounting a rootfs via
> > NFS.
>
> 2.6.32 is pretty old. =A0Is there any specific reason for not using a
> recent kernel version?
>

The company that I work for uses some kernel versions in favor of
others... Maybe with time we can change that, but for now I need to
use this version.

> > The problem that I'm facing now is that when I try to run any process (=
may
> > be an ls, cat, or whatever), the response of the process is *very* slow
> > (something like 10 to 20 seconds for a ls).
>
> This sounds as if only the output to the (serial ?) console port was
> slow - typically this happens when there is a problem with interrupt
> assignment, and you receive charatcers only after each of these times
> out.
>
> > My question to all is, did anyone see something like this already? Besi=
des
>
> We have seen this many times in the past, when interrupts were not
> working correctly. =A0I recommend to check youyr device tree settings
> for these.
>
> [It would have helped if you had included a log of your kernel's boot
> messages.]
>
> > that, what is the status of the linux kernel support for the 8xx platfo=
rm?
>
> It is working and actively maintained, but 8xx is a platform that is
> more or less hopelessly obsoleted - nobody uses it in new designs any
> more, so there is little work going on with it in recent kernel
> versions (at least compared with other architectures).
>
> > Is it being actively tested / used today? I ask this because it seems t=
hat
>
> Yes, it is.

This is very nice, because this way we can be more confident that
everything will work as it should.

>
> > all the information on the internet very aged (forum discussions from 2=
005
> > and below mostly).
>
> > Is there something that I can do to try to narrow the cause of the prob=
lem?
>
> Check your interrupts.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Never underestimate the power of human stupidity =A0when =A0it =A0comes =
=A0to
> using technology they don't understand.

Thank you very much for the answers!

Rafael Beims
rbeims@gmail.com
(41) 8873-7565
"What I hear, I forget. What I see, I remember. And what I do, I understand=
."
- Chinese Proverb
