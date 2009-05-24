Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 189A3DE063
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 00:12:38 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1304268ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 07:12:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090524111512.GD4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231301.17919.88294.stgit@terra>
	<20090524111512.GD4933@sirena.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 24 May 2009 08:12:17 -0600
Message-ID: <fa686aa40905240712k62008eacr18860c5a9480d409@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 3/9] Rename the PSC functions to DMA
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 5:15 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, May 23, 2009 at 07:13:01PM -0400, Jon Smirl wrote:
>> Rename the functions in the mpc5200 DMA file from i2s based names to dma ones to reflect the file they are in.
>
> I'm OK with both these refactoring patches if Grant is - Grant, if I
> could get your ack I'd like to merge these as soon as possible since
> they're very big changes and it'd cut down on review effort.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
