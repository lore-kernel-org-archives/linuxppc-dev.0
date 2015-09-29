Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7EA51A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:29:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 29 Sep 2015 14:29:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 48F4E2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:29:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8T4TTJX33620036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:29:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8T4T8vC031935
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:29:09 +1000
Message-ID: <560A1393.4080901@au1.ibm.com>
Date: Tue, 29 Sep 2015 14:29:07 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>, Tomas Henzl <thenzl@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Shane Seymour <shane.seymour@hp.com>
CC: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 11/32] cxlflash: Refine host/device attributes
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443222893-9345-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443222893-9345-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/09/15 09:14, Matthew R. Ochs wrote:
> Implement the following suggestions and add two new attributes
> to allow for debugging the port LUN table.
>
>   - use scnprintf() instead of snprintf()
>   - use DEVICE_ATTR_RO and DEVICE_ATTR_RW
>
> Suggested-by: Shane Seymour <shane.seymour@hp.com>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

The commit message could explain the patch a bit better.


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
