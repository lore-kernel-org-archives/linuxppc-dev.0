Return-Path: <wenxiong@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FBD22C02F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 08:01:54 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <wenxiong@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 18:01:51 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C60A338C8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 18:01:47 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55M1mdc56688852
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 18:01:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55M1m5s021033
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 18:01:48 -0400
Date: Wed, 05 Jun 2013 18:01:45 -0400
Message-ID: <20130605180145.Horde.HbMAPpir309Rr7VJiFkHOuA@imap.linux.ibm.com>
From: wenxiong@linux.vnet.ibm.com
To: Robert Knight <knight@princeton.edu>
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
In-Reply-To: <51A61B82.5050508@princeton.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Quoting Robert Knight <knight@princeton.edu>:

> Sometime after kernel 3.3.4, Fedora 17 running on an IBM OpenPower  
> 720 stopped being able to read the SCSI disks with an error  
> concerning a return code -1.  In the updates since, it has not  
> resumed working.
>
Can you tell me which kernel you saw this issue(I assumed that 3.3.4  
works fine).
Also can you check your system firmware for me?

Thanks,
Wendy
