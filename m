Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 by lists.ozlabs.org (Postfix) with ESMTP id 52E631A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 03:53:14 +1100 (AEDT)
Message-ID: <1455295989.2396.23.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 3/7] ibmvscsi: Replace magic values in
 set_adpater_info() with defines
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, jthumshirn@suse.de,
 manoj@linux.vnet.ibm.com
Date: Fri, 12 Feb 2016 08:53:09 -0800
In-Reply-To: <56BE0D7D.3050703@linux.vnet.ibm.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455295395.2396.22.camel@HansenPartnership.com>
 <56BE0D7D.3050703@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-02-12 at 08:51 -0800, Tyrel Datwyler wrote:
> On 02/12/2016 08:43 AM, James Bottomley wrote:
> > On Wed, 2016-02-10 at 19:32 -0600, Tyrel Datwyler wrote:
> > > Add defines for mad version and mad os_type, and replace the
> > > magic
> > > numbers in set_adapter_info() accordingly.
> > > 
> > > Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> > > ---
> > 
> > Is there some reason you didn't carry the review tag over from
> > this:
> > 
> > http://mid.gmane.org/20160204084459.GW27969@c203.arch.suse.de
> > 
> > ?
> > 
> > James
> 
> The patch is slightly changed from v1. A define for AIX os type was
> added as mentioned in the cover letter v2 changes, and I moved the
> defines to the mad_adapter_info_data structure around the fields they 
> apply.

OK we need a re-review then ...

James
