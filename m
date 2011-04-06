Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DD98B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 07:06:04 +1000 (EST)
Message-ID: <4D9CD5B7.3070601@embedded-sol.com>
Date: Thu, 07 Apr 2011 00:05:59 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
References: <BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>	<4D9CD1D6.6030600@embedded-sol.com>
	<BANLkTimMatkioUudyaiy+r68=MyrJqiYQg@mail.gmail.com>
In-Reply-To: <BANLkTimMatkioUudyaiy+r68=MyrJqiYQg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leon,

On 04/06/2011 11:58 PM, Leon Woestenberg wrote:
> Hello Felix,
>
> On Wed, Apr 6, 2011 at 10:49 PM, Felix Radensky<felix@embedded-sol.com>  wrote:
>> I think there's a hardware problem with mini PCI-E slot
>> on P2020RDB related to legacy IRQ routing. See this
>> thread for details
>> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg40037.html
>>
>
> Unfortunately the PCIe is slot already occupied, so that's why I
> searched for and found the Mini PCIe Sil3132 card.
>
> Legacy IRQ routing on PCIe is broken in what sense? Software (device
> tree, kernel) or silicon (p2020) ?

It's a board design problem specific to P2020RDB. Maybe it's
fixed in latest board revisions. I have P2020RDB rev C and the
problem is still there. Freescale people on the list should know
better.

> On the MSI side, I'm getting quite far on transfers, but at one point
> the device stalls. Maybe a race condition in interrupt handling in
> sata_sil24.c?

Sorry, cannot help you with that. I have no experience with
sata_sil24.

Felix.
