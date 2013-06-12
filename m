Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B68222C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 13:18:57 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 11 Jun 2013 23:18:54 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1D97FC90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 23:18:51 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5C3IpqR48431140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 23:18:51 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5C3IoLr015279
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 00:18:51 -0300
Date: Wed, 12 Jun 2013 11:18:47 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 00/27] EEH Support for PowerNV platform
Message-ID: <20130612031847.GA9641@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370936784.8250.96.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370936784.8250.96.camel@pasglop>
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

On Tue, Jun 11, 2013 at 05:46:24PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-06-05 at 15:34 +0800, Gavin Shan wrote:
>> Initially, the series of patches is built based on 3.10.RC1 and the patchset
>> doesn't intend to enable EEH functionality for PHB3 for now. Obviously, PHB3
>> EEH support on PowerNV platform is something to do in future.
>
>One thing missing here is a first patch that moves the eeh core out of
>platform/pseries or things will simply not build if CONFIG_PPC_PSERIES
>isn't enabled :-)
>
>Move the whole lot to arch/powerpc/kernel
>

Ok. Will make the first patch to do it in next revision :-)

Thanks,
Gavin
