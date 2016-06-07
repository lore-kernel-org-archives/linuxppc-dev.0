Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rP0QL0T3RzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 15:25:29 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 6 Jun 2016 23:25:27 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, tglx@linutronix.de
Subject: Re: powerpc/nvram: Fix an incorrect partition merge
In-Reply-To: <57550AB2.8090500@linux.vnet.ibm.com>
References: <3rLj4P6Swcz9t6B@ozlabs.org> <57550AB2.8090500@linux.vnet.ibm.com>
Date: Tue, 07 Jun 2016 15:24:16 +1000
Message-ID: <87bn3dlgfz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xinhui <xinhui.pan@linux.vnet.ibm.com> writes:
>> Has it always been broken?
>>
>
> no. after nvram partition corruption hit, all nvram partitions will be
> erased and re-alloc after the second machine reboot.
> I don't know who does it but i guess it is the firmware. :)

It is. PAPR says we format NVRAM when it's corrupted. This is also true
for NVRAM for PowerNV (not just pseries guest).

-- 
Stewart Smith
OPAL Architect, IBM.
