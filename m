Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3418E1A0758
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 04:17:49 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Thu, 22 Oct 2015 11:17:46 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AC0EAC90046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 13:05:54 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9MHHhCH55443584
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 17:17:43 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9MHHggv019552
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 13:17:42 -0400
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v6 35/37] cxlflash: Fix to avoid corrupting port selection
 mask
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1445458575-62688-1-git-send-email-mrochs@linux.vnet.ibm.com>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56291A42.6090504@linux.vnet.ibm.com>
Date: Thu, 22 Oct 2015 12:17:54 -0500
MIME-Version: 1.0
In-Reply-To: <1445458575-62688-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

On 10/21/2015 3:16 PM, Matthew R. Ochs wrote:
> The port selection mask of a LUN can be corrupted when the manage LUN
> ioctl (DK_CXLFLASH_MANAGE_LUN) is issued more than once for any device.
