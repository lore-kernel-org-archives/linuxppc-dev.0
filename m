Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLbDc3R6PzDsRR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 20:25:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: SZ Lin <sz.lin@moxa.com>, ashleydlai@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, peterhuewe@gmx.de,
 tpmdd@selhorst.ne, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 SZ Lin <sz.lin@moxa.com>
Subject: Re: [PATCH 2/5] Fix "ERROR: code indent should use tabs where
 possible"
In-Reply-To: <20170729072433.13194-3-sz.lin@moxa.com>
References: <20170729072433.13194-1-sz.lin@moxa.com>
 <20170729072433.13194-3-sz.lin@moxa.com>
Date: Mon, 31 Jul 2017 20:25:03 +1000
Message-ID: <87bmo06gzk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SZ Lin <sz.lin@moxa.com> writes:

> ERROR: code indent should use tabs where possible
> +^I^I         "Need to wait for TPM to finish\n");$
>
> Signed-off-by: SZ Lin <sz.lin@moxa.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index f01d083eced2..23913fc86158 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -127,7 +127,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  
>  	if (ibmvtpm->tpm_processing_cmd) {
>  		dev_info(ibmvtpm->dev,
> -		         "Need to wait for TPM to finish\n");
> +			"Need to wait for TPM to finish\n");

There's no reason for that to be on a separate line at all. Just make it
a single line dev_info( ... );

cheers
