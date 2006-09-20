Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0D2A67B77
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 02:01:24 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8KG1I4I031383
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 12:01:18 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8KG1Idl268222
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 12:01:18 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8KG1HqV009439
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 12:01:17 -0400
Subject: Re: [POWERPC] merge iSeries i/o operations with the rest
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060920221558.1322b8b4.sfr@canb.auug.org.au>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 11:01:36 -0500
Message-Id: <1158768096.19375.6.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-09-20 at 22:15 +1000, Stephen Rothwell wrote:
> +       if (firmware_has_feature(FW_FEATURE_ISERIES)) {
> +               BUG();
> +               return;
> +       }

Shouldn't all these be BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES))?

-- 
Hollis Blanchard
IBM Linux Technology Center
