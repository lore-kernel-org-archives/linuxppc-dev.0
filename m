Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id C9F8ADDEFC
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 19:07:03 +1000 (EST)
Date: Tue, 9 Sep 2008 11:06:55 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: git apply vs. renamed files index mismatch
In-Reply-To: <20080908215441.GA924@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0809091105010.27142@vixen.sonytel.be>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
	<48C59B71.3040902@freescale.com>
	<20080908215441.GA924@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-517155090-1220951215=:27142"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	git@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-517155090-1220951215=:27142
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 9 Sep 2008, Anton Vorontsov wrote:
> On Mon, Sep 08, 2008 at 04:38:57PM -0500, Scott Wood wrote:
> > Anton Vorontsov wrote:
> >> I always thought that posting "-M" patches to the public lists is
> >> discouraged since it is quite difficult to apply them via patch(1).
> >> Also think of non-git users...
> >
> > I think the substantially enhanced reviewability trumps non-git-users  
> > who can follow the rename instructions manually (or fix up their patch  
> > utility) if they insist on shunning tools that would make their life 
> > easier.
> 
> Can't disagree, I myself use git. ;-) But I'm also using standard
> patch(1) to test occasional patches... And sometimes linux-X tree
> isn't tracked by git (e.g. -mm otm snapshots).
> 
> >> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> >> new file mode 100644
> >> index 0000000..ae5708e
> >> [...]
> >> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
> >> deleted file mode 100644
> >> index ae5708e..0000000
> >>
> >> That is, if hashes match then it was pure rename.
> >
> > I suppose, though it's not as easy to spot, and won't help in showing  
> > what the differences are if there are any.
> 
> ..rename and changes ideally go in separate patches.

Except if the rename also requires some small changes (cfr. the move of
include/asm-*). But if no changes are required to fix breakage caused by the
rename, then make the changes separate.

> IIRC this also helps git to track renames (it can easily compare
> hashes instead of guessing).

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-517155090-1220951215=:27142--
