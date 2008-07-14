Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id 53F09DE0E2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 02:27:45 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so3439182wra.1
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 09:27:43 -0700 (PDT)
Message-ID: <fa686aa40807140927k23ab78eeg65ca84b2b74d01dd@mail.gmail.com>
Date: Mon, 14 Jul 2008 10:27:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
In-Reply-To: <487B7B71.9060606@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 10:14 AM, Timur Tabi <timur@freescale.com> wrote:
> Mark Brown wrote:
>
>>> The PowerPC side isn't without fault too. PowerPC still doesn't have a
>>> good way to load the fabric/machine driver.
>>
>> I'm finding it difficult to square these two statements - from an ASoC
>> point of view the main thing this patch is doing is adding a machine
>> driver and that's not something that's going to go away.
>
> Jon's concern is that there is no straightforward way to build a kernel with
> multiple fabric drivers and have the right one chosen via the device tree.  This
> is just a limitation of the device tree model, and no one has come up with a
> good solution yet.
>
> The problem still exists in ASoC V2.  However, it's not anything that ASoC
> itself needs to be concerned with.  It's purely a PowerPC problem.

It's purely an *OF Device Tree* problem.  PowerPC isn't the only
platform using the device tree.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
