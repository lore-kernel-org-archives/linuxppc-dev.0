Message-ID: <398734FC.24FEBF9D@erols.com>
Date: Tue, 01 Aug 2000 16:37:17 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Thomas Graichen <graichen@innominate.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard problems
References: <news2mail-8m5oaq$6tj$3@mate.bln.innominate.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Graichen wrote:

> i have a little keyboard problem on my blueberry imac with the
> standard usb keyboard: whenever i type something very quickly
> followed by space the typed in will be repeated before the
> space (best example: i want to type "cd " and get "cdcd ")
> - this gets a bit annoying - does anybody have the same
> problem (or even a fix for it) ? - is it more a soft-
> wareproblem (i hope :-) or maybe a hardwareproblem ?
> (i had it on all kernels from 2.2.x to 2.4.0-testx)

This is a well known issue with the usb keyboard driver.  It was a a
relatively lengthy thread a few months ago with no (AFAIK) solution,
other than "will be fixed in the future".

It has to do with depressing three keys at a time.  It takes a little
getting used to, but now, except for the occasional moment of serious
energy, I no longer strike three simultaneous keys on my Sawtooth.

HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
