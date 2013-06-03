Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B0B32C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 11:10:13 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 2 Jun 2013 21:10:11 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0BB6C6E803A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 21:10:06 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r531A928326304
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 21:10:09 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r531A8Y9024139
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 21:10:09 -0400
Date: Mon, 3 Jun 2013 09:10:06 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/23] powerpc/eeh: PowerNV EEH backends
Message-ID: <20130603011006.GC7958@shangw.(null)>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-19-git-send-email-shangw@linux.vnet.ibm.com>
 <1370060971.3766.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370060971.3766.11.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 01, 2013 at 02:29:31PM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2013-05-30 at 16:24 +0800, Gavin Shan wrote:
>> The patch adds EEH backends for PowerNV platform. It's notable that
>> part of those EEH backends call to the I/O chip dependent backends.
>
>Add a check for my new OPALv3 flag before registering since you rely
>on a whole bunch of new APIs that the current versions of OPAL don't
>have.
>

Ok. I'll do it in next version :-)

Thanks,
Gavin
