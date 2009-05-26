Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 914B9DE065
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 21:39:32 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1926962qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 04:39:30 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <9e4733910905260408x335ac337wc77e4d9ac5027f61@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
	<9e4733910905260408x335ac337wc77e4d9ac5027f61@mail.gmail.com>
Date: Tue, 26 May 2009 06:39:30 -0500
Message-ID: <ed82fe3e0905260439v7f90d2b7w3f0ee400200588e5@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 0/5] AC97 driver for mpc5200
From: Timur Tabi <timur@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
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

On Tue, May 26, 2009 at 6:08 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Mon, May 25, 2009 at 11:44 PM, Timur Tabi <timur@freescale.com> wrote:
>> On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>
>>> =A0 =A0 =A0The macro spin_event_timeout() takes a condition and timeout=
 value
>>
>> My patch is already set to go through the powerpc tree, so there's no
>> need to repost it here. =A0Please, you changed the title of the patch.
>
> I'm changing the code,

My code?  If you want to make your own version of spin_event_timeout,
then you should change the name and keep it local to your C files.

> I removed the ! on the rc. Geert just asked to
> have it changed to an in-line too.

And Geert's request won't work.

--=20
Timur Tabi
Linux kernel developer at Freescale
