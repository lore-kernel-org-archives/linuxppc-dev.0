Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433901A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 17:33:09 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 959A214031D
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 17:33:08 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 23:33:06 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BCDEE19D803F
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2016 23:21:03 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B6X4nP34406460
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 06:33:04 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B6X3IT024288
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 01:33:04 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 1/2] powerpc/powernv: new function to access OPAL msglog
In-Reply-To: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Thu, 11 Feb 2016 17:32:48 +1100
Message-ID: <87d1s3pxin.fsf@linux.vnet.ibm.com>
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

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> Currently, the OPAL msglog/console buffer is exposed as a sysfs file, with
> the sysfs read handler responsible for retrieving the log from the OPAL
> buffer. We'd like to be able to use it in xmon as well.
>
> Refactor the OPAL msglog code to create a new function, opal_msglog_copy(),
> that copies to an arbitrary buffer. Separate the initialisation code into
> generic memcons init and sysfs file creation.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
