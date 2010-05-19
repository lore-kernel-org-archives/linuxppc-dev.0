Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19AFFB7D76
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 20:44:25 +1000 (EST)
Date: Wed, 19 May 2010 10:53:05 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission >
Message-ID: <20100519105305.54804b57@lxorguk.ukuu.org.uk>
In-Reply-To: <AANLkTiljlMJKimdT-ptwXrMMBhSxFuPdVdyUuKJ8BZve@mail.gmail.com>
References: <201005051757.o45HvPmY005954@amcc.com>
	<AANLkTiljlMJKimdT-ptwXrMMBhSxFuPdVdyUuKJ8BZve@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	sr@denx.de, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 May 2010 10:49:59 +0900
Jassi Brar <jassisinghbrar@gmail.com> wrote:

> On Thu, May 6, 2010 at 2:57 AM, Rupjyoti Sarmah <rsarmah@amcc.com> wrote:
> > This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
> 
> The controller seems to be a thrid party IP (from Synopsys) in your
> SoC and there are many chances the IP will appear in some other
> SOCs too. This implementation doesn't seem to take care of that
> scenario.

I'd question if that is worth it seriously. At the point there are
multiple users of the device you know what it will look like. Until then
you neither know if the work is needed nor what will require abstracting.

Lazy evaluation is good for code too ;)

Alan
