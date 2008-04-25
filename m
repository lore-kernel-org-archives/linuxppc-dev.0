Return-Path: <helpdesk@digi.com>
Received: from mail29.messagelabs.com (mail29.messagelabs.com [216.82.249.147])
	by ozlabs.org (Postfix) with SMTP id 491BFDE138
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:31:45 +1000 (EST)
From: <Helpdesk@digi.com>
To: <akpm@linux-foundation.org>
Subject: [MailServer Resend] Quarantined email -- use caution when opening.Re:
	[PATCH 3/3] Use __weak macro for smp_setup_processor_id
Date: Fri, 25 Apr 2008 08:30:29 -0500
Message-ID: <7CA42BC0E0204516AB164DB809D5219F@digi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_04AA_01C8A6AE.9E4FF660"
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_NextPart_000_04AA_01C8A6AE.9E4FF660
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



----- Original Message Header -----
Subject: Re: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
From: benh@kernel.crashing.org;
To: akpm@linux-foundation.org;
Cc: paulus@samba.org; linuxppc-dev@ozlabs.org; 
linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org;
-----------------------------------

Warning: Attachment contains virus code or meets the filtering/blocking 
rules.  Use caution when accessing the contents. 

------=_NextPart_000_04AA_01C8A6AE.9E4FF660
Content-Type: message/rfc822;
	name="Re [PATCH 33] Use __weak macro for smp_setup_processor_id.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Re [PATCH 33] Use __weak macro for smp_setup_processor_id.eml"
Content-Description: Re [PATCH 33] Use __weak macro for
 smp_setup_processor_id.eml

Received: from mtk-sms-exch02.digi.com (10.10.8.101) by
 mtk-sms-exch01.digi.com (10.10.8.100) with Microsoft SMTP Server (TLS) id
 8.1.263.0; Fri, 18 Apr 2008 03:20:31 -0500
Received: from mcl-sms-ns1.digi.com (172.16.1.13) by mtk-sms-exch02.digi.com
 (10.10.8.101) with Microsoft SMTP Server (TLS) id 8.1.263.0; Fri, 18 Apr 2008
 03:20:31 -0500
Received: from mail164.messagelabs.com (216.82.253.131) by mail.mx1.digi.com
 (172.16.1.13) with Microsoft SMTP Server id 8.1.263.0; Fri, 18 Apr 2008
 03:20:36 -0500
X-VirusChecked: Checked
X-Env-Sender: linux-kernel-owner+EU.ML.linux-kernel=40digi.com-S1753685Ab
  YDRITb@vger.kernel.org
X-Msg-Ref: server-7.tower-164.messagelabs.com!1208506829!3942899!2
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [209.132.176.167]
X-SpamReason: No, hits=0.0 required=7.0 tests=
Received: (qmail 27767 invoked from network); 18 Apr 2008 08:20:29 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)  by
 server-7.tower-164.messagelabs.com with SMTP; 18 Apr 2008 08:20:29 -0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand	id
 S1753685AbYDRITb (ORCPT <rfc822;EU.ML.linux-kernel@digi.com>);	Fri, 18 Apr
 2008 04:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYDRITX
	(ORCPT <rfc822;linux-kernel-outgoing>);	Fri, 18 Apr 2008 04:19:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:42146 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP	id S1755940AbYDRITU
 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);	Fri, 18 Apr 2008 04:19:20
 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])	by
 gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3I8J8J7020402;	Fri, 18 Apr
 2008 03:19:09 -0500
Subject: Re: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
In-Reply-To: <20080418000717.5a9c9758.akpm@linux-foundation.org>
References: <20080418065728.31AF4DE255@ozlabs.org>
	 <20080418000717.5a9c9758.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 18:19:07 +1000
Message-ID: <1208506747.6958.402.camel@pasglop>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+EU.ML.linux-kernel=40digi.com-S1753685AbYDRITb@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 18 Apr 2008 08:20:36.8125
 (UTC)
X-MS-Exchange-Organization-PRD: vger.kernel.org
Received-SPF: None (mcl-sms-ns1.digi.com: linux-kernel-owner@vger.kernel.org
 does not designate permitted sender hosts)
X-MS-Exchange-Organization-PCL: 2
X-MS-Exchange-Organization-Antispam-Report: DV:3.3.6407.600;SID:SenderIDStatus None;OrigIP:216.82.253.131
X-MS-Exchange-Organization-OriginalSize: 3427
X-MS-Exchange-Organization-SCL: 0
X-MS-Exchange-Organization-SenderIdResult: NONE
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15856.004
X-TM-AS-Result: No--16.653400-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-MS-Exchange-Organization-AVStamp-Mailbox: SMEXJeVi;522500;0;This mail has
 been scanned by Trend Micro ScanMail for Microsoft Exchange 8.0;
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent
X-MS-Exchange-Organization-AuthSource: mcl-sms-ns1.digi.com
X-MS-Exchange-Organization-AuthAs: Anonymous


On Fri, 2008-04-18 at 00:07 -0700, Andrew Morton wrote:
> On Fri, 18 Apr 2008 16:56:18 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Use the __weak macro instead of the longer __attribute__ ((weak)) form
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > --
> > 
> >  init/main.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-work.orig/init/main.c	2008-04-18 16:44:32.000000000 +1000
> > +++ linux-work/init/main.c	2008-04-18 16:44:37.000000000 +1000
> > @@ -500,7 +500,7 @@ static void __init boot_cpu_init(void)
> >  	cpu_set(cpu, cpu_possible_map);
> >  }
> >  
> > -void __init __attribute__((weak)) smp_setup_processor_id(void)
> > +void __init __weak smp_setup_processor_id(void)
> >  {
> >  }
> 
> ack on all three. Please fold #3 into #1 and add both to git-powerpc.

Damn ! I took 5mn to actually split it out in order to not do two
different things in one patch :-)

Will do.

Cheers,
Ben.

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_04AA_01C8A6AE.9E4FF660--
