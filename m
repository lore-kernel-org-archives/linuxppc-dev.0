Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAHsu+b-xtj8DvLS-v_5-QZ3Erc-9jpFd0rodeoc4RU9YPho3tw@mail.gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-7-git-send-email-a.heider@gmail.com>
	<CAMuHMdUgK7ZkaNA+DVg0_TL8fz+AfEOTZqW5WdOY5ybwSP=hcA@mail.gmail.com>
	<CAHsu+b-xtj8DvLS-v_5-QZ3Erc-9jpFd0rodeoc4RU9YPho3tw@mail.gmail.com>
Date: Mon, 1 Aug 2011 23:00:01 +0200
Message-ID: <CAMuHMdVLJbUapn1rViWeuNEmkYofJ1L6E9M+TphZNAPQnak=BA@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 06/15] ps3flash: Fix region align checks
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Hector Martin <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 1, 2011 at 22:56, Andre Heider <a.heider@gmail.com> wrote:
> On Mon, Aug 1, 2011 at 10:29 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Aug 1, 2011 at 22:02, Andre Heider <a.heider@gmail.com> wrote:
>>> The region fields used by the align checks are set in
>>> ps3stor_setup(), so move those after that call.
>>
>> Are you sure?
>> Aren't they set in
>> arch/powerpc/platforms/ps3/device-init.c:ps3_setup_storage_dev()?
>
> Hm right, unfortunate commit message... :)
> dev->region_idx is set in ps3stor_probe_access(), which is called from
> ps3stor_setup().
> So the code always checked the first region, where it should check the
> one beeing used.

IC. You're right. That's indeed a bug.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
