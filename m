Return-Path: <brking@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 183CF2C0096
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2012 02:21:09 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Tue, 31 Jul 2012 10:21:06 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 082B91FF0023
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 16:21:00 +0000 (WET)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6VGKhrb138768
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 10:20:44 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6VGLWKZ021288
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 10:21:33 -0600
Message-ID: <501805C3.7030504@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2012 11:20:19 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] scsi/ibmvscsi: add module alias for ibmvscsic
References: <1342630158-16510-1-git-send-email-olaf@aepfle.de>
 <1343611946.21647.23.camel@pasglop> <20120730190606.GD3155@aepfle.de>
 <1343704122.8227.3.camel@pasglop>
In-Reply-To: <1343704122.8227.3.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>, Brian J King <bjking1@us.ibm.com>,
 linux-scsi@vger.kernel.org, "James E.J. Bottomley" <JBottomley@parallels.com>,
 linuxppc-dev@ozlabs.org, Robert C Jennings <rcjenn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2012 10:08 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-07-30 at 21:06 +0200, Olaf Hering wrote:
>>> So while this would work, I do wonder however whether we could
>> instead
>>> fix it by simplifying the whole thing as follow since iSeries is now
>>> gone and so we don't need split backends anymore:
>>>
>>> scsi/ibmvscsi: Remove backend abstraction
>>
>> I cant that these things myself anymore.
> 
> Brian, can somebody from your side own these ?

I talked to Rob and he will be picking this up. Rob - can you submit
a patch to the maintainers file, adding yourself as the ibmvscsi maintainer?

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
