Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wnlLc5cJFzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 21:50:16 +1000 (AEST)
Date: Wed, 14 Jun 2017 13:50:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thor Thayer <thor.thayer@linux.intel.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-edac@vger.kernel.org, mchehab@kernel.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] EDAC: altera: simplify calculation of total memory
Message-ID: <20170614115008.vqapiwx3zvlfqndn@pd.tnic>
References: <20170606235500.22772-1-chris.packham@alliedtelesis.co.nz>
 <20170606235500.22772-3-chris.packham@alliedtelesis.co.nz>
 <b052bfda-c5a3-7b23-682c-ab59c9c8ad3a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b052bfda-c5a3-7b23-682c-ab59c9c8ad3a@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 12, 2017 at 01:34:05PM -0500, Thor Thayer wrote:
> On 06/06/2017 06:54 PM, Chris Packham wrote:
> > Use of_address_to_resource() and resource_size() instead of manually
> > parsing the "reg" property from the "memory" node(s).
> > 
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---

...

> Nice change! Tested on Cyclone5 DevKit & Arria10 DevKit.
> 
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
