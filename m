Return-Path: <nab@linux-iscsi.org>
Received: from linux-iscsi.org (mail.linux-iscsi.org [67.23.28.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26A81B718F
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Feb 2011 21:36:23 +1100 (EST)
Subject: Re: [PATCH v3 3/3] tcm ibmvscsis driver
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20110214192600L.fujita.tomonori@lab.ntt.co.jp>
References: <20110214192600L.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain
Date: Mon, 14 Feb 2011 02:29:49 -0800
Message-Id: <1297679389.21049.32.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-14 at 19:25 +0900, FUJITA Tomonori wrote:
> This is the third version of tcm ibmvscsis driver. You can find the
> first version at:
> 
> http://marc.info/?t=129734085600004&r=1&w=2
> 
> The changes are:
> v3:
> - fix task attribute (convert MSG_* to TASK_ATTR_*)
> v2:
> - send VIOSRP_MAD_NOT_SUPPORTED for unknown mad type requests.
> - fix inquiry typo
> - sends task management response (for now, 'NOT SUPPORTED').
> - remove dead code.
> 
> =
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH v3 3/3] tcm ibmvscsis driver
> 
> This replaces ibmvstgt driver that uses the old target framework.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> ---
>  drivers/scsi/ibmvscsi/Makefile    |    4 +-
>  drivers/scsi/ibmvscsi/ibmvscsis.c | 1761 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 1764 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/scsi/ibmvscsi/ibmvscsis.c
> 

Merged and pushed your rev3 changes into lio-core-2.6.git/tcm_ibmvscsis

Thanks again Tomo-san!

--nab
