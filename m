Return-Path: <michaelzwrk@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by ozlabs.org (Postfix) with ESMTP id A3E4ADDE36
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 01:10:14 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so188017nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 08:10:13 -0700 (PDT)
Message-ID: <1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
Date: Wed, 11 Apr 2007 17:10:12 +0200
From: Michael <michaelzwrk@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE driver in polling mode
In-Reply-To: <20070411094702.74774d25@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
	<20070410171125.3aeed29d@the-village.bc.nu>
	<461BB8C7.9050900@garzik.org>
	<20070410172942.7f63d49c@the-village.bc.nu>
	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
	<20070411094702.74774d25@the-village.bc.nu>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I see.
The problem is I am constrained to 2.6.14 kernel.
Is it still correct to say it is P-ATA compatible?

On 4/11/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 11 Apr 2007 10:39:58 +0200
> Michael <michaelzwrk@gmail.com> wrote:
>
> > Doesn't libata have to do with SCSI devices? I'm afraid it wouldn't
> > work with CF, which is P-ATA compatible.
>
> libata drives PATA and SATA devices, including CF.
>
> > Wouldn't it work just to call ide_intr() explicitly from some polling
> > function, as Mark suggested?
>
> No. See the ATA spec - polling command issue is subtly different.
>
> Alan
>
