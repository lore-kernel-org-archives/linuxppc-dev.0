Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHtkD3MVRzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 05:52:20 +1100 (AEDT)
Received: by mail-ot0-f195.google.com with SMTP id 73so15224592otj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 10:52:20 -0800 (PST)
Date: Tue, 7 Feb 2017 12:52:17 -0600
From: Rob Herring <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: devicetree@vger.kernel.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: powerpc/fsl: Update compatible for
 l2cache binding
Message-ID: <20170207185217.b3vtbzomipn2lowm@rob-hp-laptop>
References: <20170203004316.25291-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203004316.25291-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 03, 2017 at 01:43:16PM +1300, Chris Packham wrote:
> List all the current valid compatible strings for the l2cache binding.
> This should stop checkpatch.pl from complaining and will hopefully save
> someone from having to debug a typo in their dts.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/powerpc/fsl/l2cache.txt    | 42 ++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
