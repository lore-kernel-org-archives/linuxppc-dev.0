Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id 00DA768103
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 10:26:07 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i25so839528wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 28 Aug 2005 17:26:06 -0700 (PDT)
Message-ID: <528646bc05082817268abfb1d@mail.gmail.com>
Date: Sun, 28 Aug 2005 18:26:06 -0600
From: Grant Likely <glikely@gmail.com>
To: jonathan@jonmasters.org, Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <35fb2e5905082808152031ef53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<35fb2e5905082808152031ef53@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Address mapping PPC 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/05, Jon Masters <jonmasters@gmail.com> wrote:
> On 8/26/05, P. Sadik <psadik@gmail.com> wrote:
>=20
> Lovely. We don't do it that way on 405 but we could - since the MMU is
> heavy soft assisted we could do that - we actually have everything run
> through the MMU once we've done initial MMU setup, but we do have the
> ability to mark ranges of addresses for IO and have the concept of TLB
> pinning to lock ranges of kernel addresses in large translated (BAT
> like for bigger PPC users) regions using just a few TLB slots. There
> is also a ZPR (zone protection register), but that's mostly used to
> fake the usual USER/KERNEL page distinction.
I believe TLB pinning was removed in 2.6 in favor of large TLB entries
for kernel space.  Matt Porter pointed this out to me about a week
ago.  This will not matter of course if you're not using 2.6.

Matt, is there any documentation covering the new design in the kernel tree=
?

Cheers,
g.
