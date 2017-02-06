Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vH2cL5PBzzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 20:44:18 +1100 (AEDT)
Date: Mon, 6 Feb 2017 10:43:56 +0100
From: Greg KH <greg@kroah.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 ukrishn@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: [v2] cxl: prevent read/write to AFU config space while AFU not
 configured
Message-ID: <20170206094356.GA8583@kroah.com>
References: <3v8g1Z5Gdyz9t5m@ozlabs.org>
 <1914c3dc-7e4d-30de-88b0-7959e6249f39@au1.ibm.com>
 <f3a508e9-3c23-f929-7b81-fd803c920095@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f3a508e9-3c23-f929-7b81-fd803c920095@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 06, 2017 at 12:15:59PM +1100, Andrew Donnellan wrote:
> On 27/01/17 11:57, Andrew Donnellan wrote:
> > On 27/01/17 11:40, Michael Ellerman wrote:
> > > Applied to powerpc next, thanks.
> > > 
> > > https://git.kernel.org/powerpc/c/14a3ae34bfd0bcb1cc12d55b06a858
> > 
> > Will fix the remaining locking issue in a follow up patch...
> 
> Stable team - please make sure this doesn't go in without
> http://patchwork.ozlabs.org/patch/724315/ once that's merged.

Ok, hopefully they show up in Linus's tree at the same time :)

thanks,

greg k-h
