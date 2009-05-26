Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 6248BDE03F
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 21:08:54 +1000 (EST)
Received: by qyk34 with SMTP id 34so6133405qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 04:08:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
Date: Tue, 26 May 2009 07:08:52 -0400
Message-ID: <9e4733910905260408x335ac337wc77e4d9ac5027f61@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 0/5] AC97 driver for mpc5200
From: Jon Smirl <jonsmirl@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 11:44 PM, Timur Tabi <timur@freescale.com> wrote:
> On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> =A0 =A0 =A0The macro spin_event_timeout() takes a condition and timeout =
value
>
> My patch is already set to go through the powerpc tree, so there's no
> need to repost it here. =A0Please, you changed the title of the patch.

I'm changing the code, I removed the ! on the rc. Geert just asked to
have it changed to an in-line too.

I forgot to add the title line so it used the beginning of the comment.


>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>



--=20
Jon Smirl
jonsmirl@gmail.com
