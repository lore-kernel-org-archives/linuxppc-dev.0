Return-Path: <brking@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 701A02C0340
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:11:23 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 29 May 2013 14:11:18 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 44379C90044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 14:11:16 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4TIBG4W61669468
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 14:11:16 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4TIBFDc011233
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 14:11:15 -0400
Message-ID: <51A644C2.5090300@linux.vnet.ibm.com>
Date: Wed, 29 May 2013 13:11:14 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Robert Knight <knight@princeton.edu>
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
In-Reply-To: <51A61B82.5050508@princeton.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wendy Xiong <wenxiong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2013 10:15 AM, Robert Knight wrote:
> Sometime after kernel 3.3.4, Fedora 17 running on an IBM OpenPower
> 720 stopped being able to read the SCSI disks with an error
> concerning a return code -1.  In the updates since, it has not
> resumed working.
> 
> Does the ipr driver no longer support this (admittedly ancient)
> hardware? 

Do you have a boot log you can share?

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
