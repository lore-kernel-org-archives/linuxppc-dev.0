Return-Path: <brking@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D2B01A00B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 00:41:00 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 30 Oct 2014 07:40:58 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6497619D8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 07:29:37 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9UDes3S49676528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 14:40:54 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9UDeriQ016232
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 07:40:54 -0600
Message-ID: <54523FE4.5040503@linux.vnet.ibm.com>
Date: Thu, 30 Oct 2014 08:40:52 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] ipr: Convert to generic DMA API
References: <1413191676-1663-1-git-send-email-anton@samba.org>
 <54512539.5040501@linux.vnet.ibm.com> <20141030091153.GA18224@infradead.org>
In-Reply-To: <20141030091153.GA18224@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wenxiong@linux.vnet.ibm.com, linux-scsi@vger.kernel.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/30/2014 04:11 AM, Christoph Hellwig wrote:
> On Wed, Oct 29, 2014 at 12:34:49PM -0500, Brian King wrote:
>> Acked-by: Brian King <brking@linux.vnet.ibm.com>
> 
> Doesn't apply to me.
> 
> Brain, can you please resend a rebased version of these two patches with
> ipr error handlign patch (and anything else ipr related)?
> 

Sorry. Let me rebase on top of your tree...

-Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
