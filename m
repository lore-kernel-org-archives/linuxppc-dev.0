Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4E39E302.9060702@marcansoft.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-4-git-send-email-a.heider@gmail.com>
	<4E39CC79.3050208@infradead.org> <4E39E302.9060702@marcansoft.com>
Date: Thu, 4 Aug 2011 09:05:16 +0200
Message-ID: <CAMuHMdWuefw8WM+320vr--uWTjiFo6hJrinD4HuzNFSZcM8sjQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] [PS3] Add region 1 memory early
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hector Martin <hector@marcansoft.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Andre Heider <a.heider@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 4, 2011 at 02:08, Hector Martin <hector@marcansoft.com> wrote:
> tight. Can we get rid of the ps3flash and ps3fb preallocations to save
> bootmem and just allocate them during device init like the other drivers
> do? What is the reason for preallocating these?

The reason for that is to make sure the allocations will succeed.
Chances are very
slim you can allocate a contiguous 9 MiB buffer at any arbitrary time.

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
