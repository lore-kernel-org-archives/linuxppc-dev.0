Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 549991A007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 08:37:42 +1000 (EST)
Message-ID: <1400539049.3986.71.camel@pasglop>
Subject: Re: [PATCH 2/8] powerpc/eeh: Info to trace passed devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 20 May 2014 08:37:29 +1000
In-Reply-To: <5379FD19.2020100@suse.de>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <5379FD19.2020100@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-19 at 14:46 +0200, Alexander Graf wrote:
> I don't see the point of VFIO knowing about guest addresses. They are 
> not unique across a system and the whole idea that a VFIO device has to 
> be owned by a guest is also pretty dubious.
> 
> I suppose what you really care about here is just a token for a specific 
> device? But why do you need one where we don't have tokens yet?

I think this is going to be needed when doing in-kernel acceleration
of some of the RTAS calls, but yes, Gavin, why do we need that now ?

Cheers,
Ben.
