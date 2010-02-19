Return-Path: <rayan@nucleodyne.com>
Received: from easyspace2.ezspl.net (easyspace2.ezspl.net [66.45.254.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C23CB7CF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 16:34:36 +1100 (EST)
Received: from mail-gx0-f228.google.com ([209.85.217.228])
	by easyspace2.ezspl.net with esmtpsa (TLSv1:RC4-MD5:128) (Exim 4.69)
	(envelope-from <rayan@nucleodyne.com>) id 1NiLVZ-0005wj-1g
	for linuxppc-dev@lists.ozlabs.org; Fri, 19 Feb 2010 00:34:33 -0500
Received: by gxk28 with SMTP id 28so2750434gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Feb 2010 21:34:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100218131541.GB18514@pengutronix.de>
References: <5bbdacc81002172233x64a05ae2m4ecdbddf85dac8c0@mail.gmail.com>
	<20100218131541.GB18514@pengutronix.de>
Date: Thu, 18 Feb 2010 21:34:28 -0800
Message-ID: <5bbdacc81002182134l64c46bf1mc2a4b4fc268e6eee@mail.gmail.com>
Subject: Re: State of PREEMPT_RT in PPC arch
From: Ryan <rayan@nucleodyne.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2010 at 5:15 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
> > I'm soliciting comments from the community. Thanks in advance for
> > sharing your thoughts.
>
> Mainline your driver and you are free from such problems :)

Shouldn't it be the opposite way? That is, get drivers working first
then mainline them? I even don't have a working driver with RT patch.
Thanks for the response though. At least it shows that such emails are
not completely ignored.

I feel the linuxppc-dev mailing list is full of development patches
and discussions about them, kinda dedicated to active developers. Is
there a place that users or not-so-active developers can post
technical questions and get some relatively quick answers or comments?
I think there used to be such a mailing list but I couldn't remember
it.

-Ryan.
