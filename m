Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvhYz3YwfzDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 02:04:38 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jan Kara
 <jack@suse.cz>, "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>, Will Deacon <will.deacon@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "sparclinux@vger.kernel.org"
 <sparclinux@vger.kernel.org>, "linux-ia64@vger.kernel.org"
 <linux-ia64@vger.kernel.org>, Christoph Lameter <cl@linux.com>, "Andrea
 Arcangeli" <aarcange@redhat.com>, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Russell King
 <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, PaX Team <pageexec@freemail.hu>, Borislav Petkov
 <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Fenghua Yu
 <fenghua.yu@intel.com>, Rik van Riel <riel@redhat.com>, David Rientjes
 <rientjes@google.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
 <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Laura Abbott
 <labbott@fedoraproject.org>, Brad Spengler <spender@grsecurity.net>, "Ard
 Biesheuvel" <ard.biesheuvel@linaro.org>, Pekka Enberg <penberg@kernel.org>,
 Daniel Micay <danielmicay@gmail.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [PATCH v3 00/11] mm: Hardened usercopy
Date: Wed, 20 Jul 2016 16:02:39 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4FEA62@AcuExch.aculab.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <063D6719AE5E284EB5DD2968C1650D6D5F4FD6A3@AcuExch.aculab.com>
 <CAGXu5j+QH8Fdk7p6bZV_yMv1puHRxZRu5z45+tKrmLyGBTymFw@mail.gmail.com>
In-Reply-To: <CAGXu5j+QH8Fdk7p6bZV_yMv1puHRxZRu5z45+tKrmLyGBTymFw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDIwIEp1bHkgMjAxNiAxNjozMg0KLi4uDQo+IFl1cDog
dGhhdCdzIGV4YWN0bHkgd2hhdCBpdCdzIGRvaW5nOiB3YWxraW5nIHVwIHRoZSBzdGFjay4gOikN
Cg0KUmVtaW5kIG1lIHRvIG1ha2Ugc3VyZSBhbGwgb3VyIGN1c3RvbWVycyBydW4ga2VybmVscyB3
aXRoIGl0IGRpc2FibGVkLg0KDQoJRGF2aWQNCg0K
