Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id 2DF54DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 08:43:25 +1000 (EST)
Message-ID: <4717DEE8.9010508@gmail.com>
Date: Thu, 18 Oct 2007 18:32:08 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: qe: add ability to upload QE firmware
References: <11927201051427-git-send-email-timur@freescale.com>
In-Reply-To: <11927201051427-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Define the layout of a binary blob that contains a QE firmware and instructions
> on how to upload it.  Add function qe_upload_microcode() to parse the blob
> and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
> include the actual RISC Special Registers.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

[snip]

> +/*
> + * Download a microcode to the I-RAM at a specific address.
       ^^^^^^^^
> + *
> + * @firmware: pointer to qe_firmware structure
> + */
> +int qe_upload_microcode(const struct qe_firmware *firmware)
           ^^^^^^
We seem to be a little conflicted over whether it is an upload or a 
download.  ;-)

gvb
