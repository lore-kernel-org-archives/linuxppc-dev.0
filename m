Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50AB2B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 06:49:32 +1000 (EST)
Message-ID: <4D9CD1D6.6030600@embedded-sol.com>
Date: Wed, 06 Apr 2011 23:49:26 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, leon.woestenberg@gmail.com
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
References: <BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
In-Reply-To: <BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leon,

I think there's a hardware problem with mini PCI-E slot
on P2020RDB related to legacy IRQ routing. See this
thread for details
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg40037.html

You may have better luck with PCI-E slot and mini PCI-E to
PCI-E adapter.

Felix.
