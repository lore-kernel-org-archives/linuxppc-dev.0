Return-Path: <vinholikatti@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
Date: Tue, 27 Nov 2012 17:02:51 +0530
Message-ID: <CAKVbJB9wTj9HtXYTW0Le+oHsdMACkuBnf2jSXu-pAx+gPKoBYA@mail.gmail.com>
Subject: Re: [PATCH 192/493] scsi: remove use of __devinit
From: vinayak holikatti <vinholikatti@gmail.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Oliver Neukum <oliver@neukum.org>,
 VMware PV-Drivers <pv-drivers@vmware.com>, Kurt Garloff <garloff@suse.de>,
 =?ISO-8859-1?Q?Kai_M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 GOTO Masanori <gotom@debian.or.jp>, Russell King <linux@arm.linux.org.uk>,
 linux-scsi@vger.kernel.org, Jamie Lenehan <lenehan@twibble.org>,
 osst-users@lists.sourceforge.net, Michael Reed <mdr@sgi.com>,
 cbe-oss-dev@lists.ozlabs.org, iss_storagedev@hp.com,
 Matthew Wilcox <matthew@wil.cx>, Ali Akcaagac <aliakc@web.de>,
 dc395x@twibble.org, linux-arm-kernel@lists.infradead.org,
 Neela Syam Kolli <megaraidlinux@lsi.com>, Geoff Levand <geoff@infradead.org>,
 gregkh@linuxfoundation.org, Arvind Kumar <arvindkumar@vmware.com>,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Willem Riede <osst@riede.org>, YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 linuxppc-dev@lists.ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>  drivers/scsi/ufs/ufshcd.c                 |  2 +-

Acked-by: Vinayak Holikatti <vinholikatti@gmail.com>

only for drivers/scsi/ufs/ufshcd.c

> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 4a370f8..a79ff87 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1811,7 +1811,7 @@ static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>   *
>   * Returns 0 on success, non-zero value on failure
>   */
> -static int __devinit
> +static int
>  ufshcd_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>         struct Scsi_Host *host;


-- 
Regards,
Vinayak Holikatti
