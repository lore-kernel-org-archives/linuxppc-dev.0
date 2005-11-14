Return-Path: <jesper.juhl@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id F1B8468724
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2005 12:04:30 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id 8so1025827nzo
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 17:04:28 -0800 (PST)
Message-ID: <9a8748490511131704m18dcfa37re8100b469388fe3c@mail.gmail.com>
Date: Mon, 14 Nov 2005 02:04:28 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Michael Buesch <mbuesch@freenet.de>
In-Reply-To: <200511122237.17157.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/12/05, Michael Buesch <mbuesch@freenet.de> wrote:
> On Saturday 12 November 2005 22:00, you wrote:
> >
> > On Sat, 12 Nov 2005, Michael Buesch wrote:
> > >
> > > Latest GIT tree does not boot on my G4 PowerBook.
> >
> > What happens if you do
> >
> >       make ARCH=3Dpowerpc
> >
> > and build everything that way (including the "config" phase)?
>
> I did
> make mrproper
> copy the .config over again

are you not missing a "make oldconfig" step here?

> make ARCH=3Dpowerpc menuconfig


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
