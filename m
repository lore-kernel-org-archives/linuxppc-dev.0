Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f188.google.com (mail-iw0-f188.google.com
	[209.85.223.188]) by ozlabs.org (Postfix) with ESMTP id 48402B7E36
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 08:22:58 +1100 (EST)
Received: by iwn26 with SMTP id 26so530299iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 13:22:57 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100311193458.GA13289@opensource.wolfsonmicro.com>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180649.4824.10368.stgit@angua>
	<20100311193458.GA13289@opensource.wolfsonmicro.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 14:22:37 -0700
Message-ID: <fa686aa41003111322wc1f15b2hd3f653af060f56bf@mail.gmail.com>
Subject: Re: [PATCH 33/37] sound/soc: use .dev.of_node instead of .node in
	struct of_device
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, linux-ide@vger.kernel.org,
	James.Bottomley@suse.de, linux-i2c@vger.kernel.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com,
	sfr@canb.auug.org.au, linux-scsi@vger.kernel.org,
	jgarzik@pobox.com, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, ben-linux@fluff.org,
	timur@freescale.com, lrg@slimlogic.co.uk, monstr@monstr.eu,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 11, 2010 at 12:34 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Mar 11, 2010 at 11:06:50AM -0700, Grant Likely wrote:
>> .node is being removed
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> but please ensure that Liam and especially Timur also check this (both
> CCed).
>
> For enormous patch serieses like this it's really nice if you can ensure
> that each person is only CCed on the patches that they need to review.
> Much less stuff in the inbox.

Yeah, sorry about that (and to everyone receiving this thread, I'm
really sorry.  I won't do it again).  I've already been yelled at for
that.  What happened is that on a previous series I was yelled at for
not sending all patches to everyone (so that the patches could be
reviewed in context).  So, naturally, I made sure to include everyone
on the whole series this time....  doh.

Next time I post I'll constrain it to small chunks.

Thanks for the review.

g.
