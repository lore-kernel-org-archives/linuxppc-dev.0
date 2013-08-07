Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 457212C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 12:37:02 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 6 Aug 2013 20:36:59 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5BBD019D8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 20:34:32 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r772YiWb199144
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Aug 2013 20:34:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r772Yi0I010133
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Aug 2013 20:34:44 -0600
Date: Wed, 7 Aug 2013 10:34:40 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Add procfs entry for PowerNV
Message-ID: <20130807023440.GB16844@shangw.(null)>
References: <1375842314-26555-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375842314-26555-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 10:25:14PM -0400, Mike Qiu wrote:
>The procfs entry for global statistics has been missed on PowerNV
>platform and the patch is going to add that.
>
>Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
> arch/powerpc/kernel/eeh.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 39954fe..0e12bb1 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -1063,7 +1063,7 @@ static const struct file_operations proc_eeh_operations = {
>
> static int __init eeh_init_proc(void)
> {
>-	if (machine_is(pseries))
>+	if (machine_is(pseries) || machine_is(powernv))
> 		proc_create("powerpc/eeh", 0, NULL, &proc_eeh_operations);
> 	return 0;
> }

Thanks,
Gavin
