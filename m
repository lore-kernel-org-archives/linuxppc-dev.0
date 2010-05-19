Return-Path: <jassisinghbrar@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 7DEA1B7D57
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 21:19:20 +1000 (EST)
Received: by vws18 with SMTP id 18so799669vws.15
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 04:19:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100519105305.54804b57@lxorguk.ukuu.org.uk>
References: <201005051757.o45HvPmY005954@amcc.com>
	<AANLkTiljlMJKimdT-ptwXrMMBhSxFuPdVdyUuKJ8BZve@mail.gmail.com>
	<20100519105305.54804b57@lxorguk.ukuu.org.uk>
Date: Wed, 19 May 2010 20:19:18 +0900
Message-ID: <AANLkTikJVJPn6eG8YsM2tDJxxo49cuKdstmZRdNkV1Te@mail.gmail.com>
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission >
From: Jassi Brar <jassisinghbrar@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=UTF-8
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

On Wed, May 19, 2010 at 6:53 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 19 May 2010 10:49:59 +0900
> Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
>> On Thu, May 6, 2010 at 2:57 AM, Rupjyoti Sarmah <rsarmah@amcc.com> wrote:
>> > This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
>>
>> The controller seems to be a thrid party IP (from Synopsys) in your
>> SoC and there are many chances the IP will appear in some other
>> SOCs too. This implementation doesn't seem to take care of that
>> scenario.
>
> I'd question if that is worth it seriously. At the point there are
> multiple users of the device you know what it will look like. Until then
> you neither know if the work is needed nor what will require abstracting.
Well, am to start writing driver for some dwc sata core in near
future, not sure of the
exact version because I've not yet had my hands on the specs.
Even if my version happens to be different, we don't wanna count on such odds.
So I believe it's worthwhile.

Btw, I presented two options and the author can always choose the
first one - rename
the driver as SoC specific. And in a way, I'd prefer that :)

> Lazy evaluation is good for code too ;)
Apart from increasing re-usability, that POV brings out neat code too.
