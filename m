Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3BBDF2C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 17:16:35 +1000 (EST)
Message-ID: <1376032572.32100.17.camel@pasglop>
Subject: Re: [PATCH 3/8] Add all memory via sysfs probe interface at once
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 09 Aug 2013 17:16:12 +1000
In-Reply-To: <52016047.5060903@linux.vnet.ibm.com>
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01EFB.6070207@linux.vnet.ibm.com> <20130802023259.GC1680@concordia>
 <51FC04C2.70100@linux.vnet.ibm.com> <20130805031326.GB5347@concordia>
 <52016047.5060903@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 isimatu.yasuaki@jp.fujitsu.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-06 at 15:44 -0500, Nathan Fontenot wrote:
> I am planning on pulling the first two patches and sending them out
> separate from the patch set since they are really independent of the
> rest of the patch series.
> 
> The remaining code I will send out for review and inclusion in
> linux-next so it can have the proper test time as you mentioned.

Ping ? :-)

Cheers,
Ben.
