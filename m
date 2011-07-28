Return-Path: <vapier.adi@gmail.com>
Received: from mail-gw0-f44.google.com (mail-gw0-f44.google.com [74.125.83.44])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94027B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jul 2011 10:12:55 +1000 (EST)
Received: by gwb20 with SMTP id 20so2214581gwb.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jul 2011 17:12:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1311762043.25044.679.camel@pasglop>
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
	<1311761831.24752.413.camel@twins> <1311762043.25044.679.camel@pasglop>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Wed, 27 Jul 2011 17:12:32 -0700
Message-ID: <CAMjpGUdXfzt5HuDgspf6Bijm3xOPcck_JR38-AV2FSK0t99MTQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW tracking
	of dirty & young
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: tony.luck@intel.com, Shan Hai <haishan.bai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	David Howells <dhowells@redhat.com>, paulus@samba.org,
	uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2011 at 03:20, Benjamin Herrenschmidt wrote:
> Hoping the BUG() isn't trippable by userspace but then it's no mmu, it's
> not like we care what userspace can do right :-)

side note ... common misconception that "no mmu" == "no memory
protection".  a few of the nommu processors have memory protection,
just no virtual<->physical translation.

thanks for the patch !
-mike
