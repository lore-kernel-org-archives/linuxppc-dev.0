Return-Path: <brking@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 957122C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 08:16:20 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Tue, 4 Jun 2013 18:16:16 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D855238C8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 18:16:12 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r54MGDHo57671778
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jun 2013 18:16:13 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r54MGDrH016113
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jun 2013 18:16:13 -0400
Message-ID: <51AE672C.1060805@linux.vnet.ibm.com>
Date: Tue, 04 Jun 2013 17:16:12 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Robert Knight <knight@princeton.edu>
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com> <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
In-Reply-To: <51AD45A4.9080702@princeton.edu>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, Wendy Xiong <wenxiong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2013 08:40 PM, Robert Knight wrote:
> [   21.938847] ipr: IBM Power RAID SCSI Device Driver version: 2.5.4 (July 11, 2
> 012)
> [   21.939061] ipr 0001:d0:01.0: Found IOA with IRQ: 151
> [   21.942276] ipr 0001:d0:01.0: Write of cache line size failed
> [   21.942584] ipr: probe of 0001:d0:01.0 failed with error -5

This looks to be the reason the ipr driver is failing to load. Not sure why this
is failing, I don't think this code has changed for a very long time. Arguably,
this shouldn't be a fatal error for the driver. Wendy - do you have access to
one of these systems so we could take a look at this? 

-Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
