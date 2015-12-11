Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADEC41A05F4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 01:53:31 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Fri, 11 Dec 2015 09:53:28 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7705B6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 09:41:35 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBBErQtv15859742
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 14:53:26 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBBErOfg015013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 09:53:25 -0500
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH 2/6] cxlflash: Fix to avoid virtual LUN failover failure
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1449788029-23093-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <566AE369.3070809@linux.vnet.ibm.com>
Date: Fri, 11 Dec 2015 08:53:29 -0600
MIME-Version: 1.0
In-Reply-To: <1449788029-23093-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2015 4:53 PM, Uma Krishnan wrote:
> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
> To remedy this scenario, provide feedback back to the application on
> virtual LUN creation as to which ports the LUN may be accessed. LUN's
> spanning both ports are candidates for a retry in a presence of an I/O
> failure.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Acked-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
