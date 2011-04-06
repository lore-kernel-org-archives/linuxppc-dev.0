Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACDEAB6F0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 06:58:22 +1000 (EST)
Received: by pwi9 with SMTP id 9so790715pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Apr 2011 13:58:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4D9CD1D6.6030600@embedded-sol.com>
References: <BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
	<4D9CD1D6.6030600@embedded-sol.com>
Date: Wed, 6 Apr 2011 22:58:04 +0200
Message-ID: <BANLkTimMatkioUudyaiy+r68=MyrJqiYQg@mail.gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Felix Radensky <felix@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Felix,

On Wed, Apr 6, 2011 at 10:49 PM, Felix Radensky <felix@embedded-sol.com> wrote:
> I think there's a hardware problem with mini PCI-E slot
> on P2020RDB related to legacy IRQ routing. See this
> thread for details
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg40037.html
>
Thanks for the heads-up.

> You may have better luck with PCI-E slot and mini PCI-E to
> PCI-E adapter.
>
Unfortunately the PCIe is slot already occupied, so that's why I
searched for and found the Mini PCIe Sil3132 card.

Legacy IRQ routing on PCIe is broken in what sense? Software (device
tree, kernel) or silicon (p2020) ?

On the MSI side, I'm getting quite far on transfers, but at one point
the device stalls. Maybe a race condition in interrupt handling in
sata_sil24.c?

Regards,
-- 
Leon
