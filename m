To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: hdparm and disc errors
References: <4vr8t0veui.fsf@darbujan.fzu.cz>
	<20010921142218.5696@smtp.adsl.oleane.com>
From: Jiri Masik <masik@pc203b.fzu.cz>
Date: 24 Sep 2001 11:40:45 +0200
Message-ID: <4vhett0vvm.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> >Do you think it is a real disc failure or is anything wrong with the
> >hdparm setting? Is the unmasking dangerous for Pismo?
>
> That's weird. Note that there are chances that 2.2 lockup on such IDE errors.
>
> The driver did evolve slightly, but not in a way that explains your problem.
>
> Ben.

Hi Ben,

it does not happen with 2.2 at all. I think there was a change in the
driver before 2.4.8-ben0. This is the first kernel I tried which
actually reports the error. Before that I had 2.4.7-ben0 and
2.4.6-pre8 which were crashing without anything reported. I guess it
was caused by the disc as well as the crash was accompanied by the
sound of repeated access to a faulty floppy disc.

Jiri


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
