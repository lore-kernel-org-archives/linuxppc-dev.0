Return-Path: <vapier.adi@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AAC7B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Aug 2011 12:32:00 +1000 (EST)
Received: by fxh10 with SMTP id 10so4755168fxh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 07 Aug 2011 19:31:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1311761831.24752.413.camel@twins>
References: <1311757190.24752.406.camel@twins>
	<1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins>
	<4E21A526.8010904@gmail.com> <1310860194.25044.17.camel@pasglop>
	<4b337921-d430-4b63-bc36-ad31753cf800@email.android.com>
	<1310912990.25044.203.camel@pasglop>
	<1310944453.25044.262.camel@pasglop>
	<1310961691.25044.274.camel@pasglop>
	<4E23D728.7090406@gmail.com> <1310972462.25044.292.camel@pasglop>
	<4E23E02C.8090401@gmail.com> <1310974591.25044.298.camel@pasglop>
	<4E24FA51.70602@gmail.com> <1311049762.25044.392.camel@pasglop>
	<CAMjpGUdxpaYBFfKjBEPFOJohnKoXfagLUHvhrst+NembeabxcA@mail.gmail.com>
	<1311753513.25044.663.camel@pasglop> <20368.1311761379@redhat.com>
	<1311761831.24752.413.camel@twins>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Sun, 7 Aug 2011 22:31:35 -0400
Message-ID: <CAMjpGUdVo-s-882wRs7J=q_fgs_CcY2cBsRE8fbmAoVvhkF6Fg@mail.gmail.com>
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW tracking
	of dirty & young
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: tony.luck@intel.com, Shan Hai <haishan.bai@gmail.com>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	stable@kernel.org, David Howells <dhowells@redhat.com>,
	paulus@samba.org, uclinux-dist-devel@blackfin.uclinux.org,
	tglx@linutronix.de, walken@google.com,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2011 at 06:17, Peter Zijlstra wrote:
> On Wed, 2011-07-27 at 11:09 +0100, David Howells wrote:
>> Can you inline this for the NOMMU case please?
>
> ---
> Subject: mm: Fix fixup_user_fault() for MMU=n
>
> In commit 2efaca927 ("mm/futex: fix futex writes on archs with SW
> tracking of dirty & young") we forgot about MMU=n. This patch fixes
> that.

can we get this merged ?  mainline is now broken, linux-next is still
broken, and it seems gregkh is pulling this into the stable 3.0.1
which means that's going to be broken too.
-mike
