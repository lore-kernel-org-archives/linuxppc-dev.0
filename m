Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 449612C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 14:24:58 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 1 Aug 2013 00:24:53 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A0E5D6E803A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 00:24:46 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r714OpJs193568
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Aug 2013 00:24:51 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r714Opmv025733
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Aug 2013 01:24:51 -0300
Date: Thu, 1 Aug 2013 12:24:46 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] powerpc/powernv: Pick up correct number of PEs
Message-ID: <20130801042446.GA5540@shangw.(null)>
References: <1375260424-20777-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1375260424-20777-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1375262326.3743.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375262326.3743.4.camel@pasglop>
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

On Wed, Jul 31, 2013 at 07:18:46PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-07-31 at 16:47 +0800, Gavin Shan wrote:
>> Usually, the property "ibm,opal-num-pes" of PHB dev-tree node
>> indicates the number of total PEs. If that property isn't existing
>> or valid, we should fall back to pick the correct number of total
>> PEs according to PHB type: IODA1 or IODA2.
>
>Is that correct ? Don't we get the total number of PEs from a config
>register on the bridge ? I didn't think the IODA architecture specified
>the total number of PE of a given implementation...
>

For now, the firmware has fixed values (1/128/256), which isn't figured
out from EEH capability register. That might be something to do later
for the f/w.

>For example, does Torrent implement 128 ?
>

I don't know what's "Torrent" :-)

>I'd rather stick to safe here, if the firmware doesn't say, just use
>one.
>
>Now some of the PHB registers are actually architected in IODA afaik, so
>we could just go look but let's not make a precedent here.
>

Ok. Thanks, Ben. Please drop this one :-)

Thanks,
Gavin
