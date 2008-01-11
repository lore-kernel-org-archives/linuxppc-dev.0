Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id E97BCDDE99
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 10:30:38 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so306639anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 15:30:37 -0800 (PST)
Message-ID: <fa686aa40801111530j7cb77bf7i1b9d89fa8f71ac7d@mail.gmail.com>
Date: Fri, 11 Jan 2008 16:30:36 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@jdl.com>
Subject: Re: StorCenter Help?
In-Reply-To: <E1JDTFP-0007OE-MM@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1JDT1Q-0007Bj-1Q@jdl.com>
	<fa686aa40801111520m3b9c3ea6rc7ee38519dcc9a4b@mail.gmail.com>
	<E1JDTFP-0007OE-MM@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/11/08, Jon Loeliger <jdl@jdl.com> wrote:
> So, like, the other day "Grant Likely" mumbled:
> >
> > Since you're getting absolutely no output after uncompression it
> > probably means that you're failing in the boot wrapper...
>
> Or not getting to the boot wrapper...

Hmm, yet it boots a regular uImage?

> > which means mmu is off, and the serial port is already set up by u-boot.
> >
> > You should be able to add direct writes to the uart fifo register from
> > within the bootwrapper code to see how far you get in the progress.
>
> Tried that.  Didn't work at all.
>
> I think I have some variant of BAT setup failure or so.

weird...  Can you get *any* custom code to run *at all*?  Even if it's
just a loop that writes a char to the serial port?

>
> jdl
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
