Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC0F91A0A4A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 23:16:08 +1000 (AEST)
Subject: Re: [PATCH v5 10/34] cxlflash: Make functions static
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443714936-15625-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <560E8393.6060904@redhat.com>
Date: Fri, 2 Oct 2015 15:16:03 +0200
MIME-Version: 1.0
In-Reply-To: <1443714936-15625-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1.10.2015 17:55, Matthew R. Ochs wrote:
> Found during code inspection, that the following functions are not
> being used outside of the file where they are defined. Make them static.
>
> int cxlflash_send_cmd(struct afu *, struct afu_cmd *);
> void cxlflash_wait_resp(struct afu *, struct afu_cmd *);
> int cxlflash_afu_reset(struct cxlflash_cfg *);
> struct afu_cmd *cxlflash_cmd_checkout(struct afu *);
> void cxlflash_cmd_checkin(struct afu_cmd *);
> void init_pcr(struct cxlflash_cfg *);
> int init_global(struct cxlflash_cfg *);
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Tomas
