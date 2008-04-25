Return-Path: <helpdesk@digi.com>
Received: from mail29.messagelabs.com (mail29.messagelabs.com [216.82.249.147])
	by ozlabs.org (Postfix) with SMTP id 0AE4ADE034
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:31:45 +1000 (EST)
From: <Helpdesk@digi.com>
To: <benh@kernel.crashing.org>
Subject: [MailServer Resend] Quarantined email -- use caution when opening.Re:
	[PATCH 3/3] Use __weak macro for smp_setup_processor_id
Date: Fri, 25 Apr 2008 08:30:29 -0500
Message-ID: <92138076484D4EDEB705BCDB47E35673@digi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_04A7_01C8A6AE.9E48F180"
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

------=_NextPart_000_04A7_01C8A6AE.9E48F180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



----- Original Message Header -----
Subject: Re: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
From: akpm@linux-foundation.org;
To: benh@kernel.crashing.org;
Cc: paulus@samba.org; linuxppc-dev@ozlabs.org; 
linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org;
-----------------------------------

Warning: Attachment contains virus code or meets the filtering/blocking 
rules.  Use caution when accessing the contents. 

------=_NextPart_000_04A7_01C8A6AE.9E48F180
Content-Type: message/rfc822;
	name="Re [PATCH 33] Use __weak macro for smp_setup_processor_id.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Re [PATCH 33] Use __weak macro for smp_setup_processor_id.eml"
Content-Description: Re [PATCH 33] Use __weak macro for
 smp_setup_processor_id.eml

Received: from mcl-sms-ns1.digi.com (172.16.1.13) by mtk-sms-exch01.digi.com
 (10.10.8.100) with Microsoft SMTP Server (TLS) id 8.1.263.0; Fri, 18 Apr 2008
 03:40:51 -0500
Received: from mail164.messagelabs.com (216.82.253.131) by mail.mx1.digi.com
 (172.16.1.13) with Microsoft SMTP Server id 8.1.263.0; Fri, 18 Apr 2008
 03:40:56 -0500
X-VirusChecked: Checked
X-Env-Sender: linux-kernel-owner+EU.ML.linux-kernel=40digi.com-S1753389Ab
  YDRIjO@vger.kernel.org
X-Msg-Ref: server-12.tower-164.messagelabs.com!1208508049!20497006!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [209.132.176.167]
X-SpamReason: No, hits=0.0 required=7.0 tests=
Received: (qmail 27327 invoked from network); 18 Apr 2008 08:40:49 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)  by
 server-12.tower-164.messagelabs.com with SMTP; 18 Apr 2008 08:40:49 -0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand	id
 S1753389AbYDRIjO (ORCPT <rfc822;EU.ML.linux-kernel@digi.com>);	Fri, 18 Apr
 2008 04:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbYDRIjM
	(ORCPT <rfc822;linux-kernel-outgoing>);	Fri, 18 Apr 2008 04:39:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45559 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)	by vger.kernel.org with
 ESMTP id S1752771AbYDRIjK (ORCPT	<rfc822;linux-kernel@vger.kernel.org>);	Fri,
 18 Apr 2008 04:39:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
 [140.211.169.55])	by smtp1.linux-foundation.org
 (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3I8d1LX002809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);	Fri, 18
 Apr 2008 01:39:03 -0700
Received: from y.localdomain (localhost [127.0.0.1])	by
 imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with
 SMTP id m3I8cws6019612;	Fri, 18 Apr 2008 01:38:59 -0700
Date: Fri, 18 Apr 2008 01:38:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
Message-ID: <20080418013857.92824cfb.akpm@linux-foundation.org>
In-Reply-To: <1208506747.6958.402.camel@pasglop>
References: <20080418065728.31AF4DE255@ozlabs.org>
	<20080418000717.5a9c9758.akpm@linux-foundation.org>
	<1208506747.6958.402.camel@pasglop>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-3.291 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: <linux-kernel-owner@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+EU.ML.linux-kernel=40digi.com-S1753389AbYDRIjO@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 18 Apr 2008 08:40:56.9375
 (UTC)
X-MS-Exchange-Organization-PRD: vger.kernel.org
Received-SPF: None (mcl-sms-ns1.digi.com: linux-kernel-owner@vger.kernel.org
 does not designate permitted sender hosts)
X-MS-Exchange-Organization-PCL: 2
X-MS-Exchange-Organization-Antispam-Report: DV:3.3.6407.600;SID:SenderIDStatus None;OrigIP:216.82.253.131
X-MS-Exchange-Organization-OriginalSize: 4353
X-MS-Exchange-Organization-SCL: 0
X-MS-Exchange-Organization-SenderIdResult: NONE
X-MS-Exchange-Organization-AuthSource: mcl-sms-ns1.digi.com
X-MS-Exchange-Organization-AuthAs: Anonymous

On Fri, 18 Apr 2008 18:19:07 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2008-04-18 at 00:07 -0700, Andrew Morton wrote:
> > On Fri, 18 Apr 2008 16:56:18 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > Use the __weak macro instead of the longer __attribute__ ((weak)) form
> > > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > --
> > > 
> > >  init/main.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- linux-work.orig/init/main.c	2008-04-18 16:44:32.000000000 +1000
> > > +++ linux-work/init/main.c	2008-04-18 16:44:37.000000000 +1000
> > > @@ -500,7 +500,7 @@ static void __init boot_cpu_init(void)
> > >  	cpu_set(cpu, cpu_possible_map);
> > >  }
> > >  
> > > -void __init __attribute__((weak)) smp_setup_processor_id(void)
> > > +void __init __weak smp_setup_processor_id(void)
> > >  {
> > >  }
> > 
> > ack on all three. Please fold #3 into #1 and add both to git-powerpc.
> 
> Damn ! I took 5mn to actually split it out in order to not do two
> different things in one patch :-)

ah, I misread it.  I thought this was changing the __attribute__((weak))
which patch #1 added.  But it's changing a different one.  I though that
was odd.

> Will do.

whatever ;)
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_04A7_01C8A6AE.9E48F180--
