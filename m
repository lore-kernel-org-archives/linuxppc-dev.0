Return-Path: <jassisinghbrar@gmail.com>
Received: from mail-vw0-f41.google.com (mail-vw0-f41.google.com
	[209.85.212.41]) by ozlabs.org (Postfix) with ESMTP id 8F831B7D74
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 11:50:01 +1000 (EST)
Received: by vws12 with SMTP id 12so1400627vws.0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 18:50:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201005051757.o45HvPmY005954@amcc.com>
References: <201005051757.o45HvPmY005954@amcc.com>
Date: Wed, 19 May 2010 10:49:59 +0900
Message-ID: <AANLkTiljlMJKimdT-ptwXrMMBhSxFuPdVdyUuKJ8BZve@mail.gmail.com>
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission >
From: Jassi Brar <jassisinghbrar@gmail.com>
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ide@vger.kernel.org, sr@denx.de, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 6, 2010 at 2:57 AM, Rupjyoti Sarmah <rsarmah@amcc.com> wrote:
> This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.

The controller seems to be a thrid party IP (from Synopsys) in your
SoC and there are many chances the IP will appear in some other
SOCs too. This implementation doesn't seem to take care of that
scenario.
So, please either call the driver something like sata_460ex.c
or, better still, segregate the driver in two parts - SoC specific stuff
and DWC IP core driver that can be reused by other SoCs having the
same IP in future.
