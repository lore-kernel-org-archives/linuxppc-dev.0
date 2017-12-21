Return-Path: <greg@kroah.com>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2PKd1rdvzF0BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 19:03:48 +1100 (AEDT)
Date: Thu, 21 Dec 2017 09:03:47 +0100
From: Greg KH <greg@kroah.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cxl: Check if vphb exists before iterating over AFU
 devices
Message-ID: <20171221080347.GA10992@kroah.com>
References: <20171221040619.25270-1-vaibhav@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221040619.25270-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 21, 2017 at 09:36:19AM +0530, Vaibhav Jain wrote:
> commit 12841f87b7a8ceb3d54f171660f72a86941bfcb3 upstream, for 4.3.

Thanks, now applied to 4.4.

greg k-h
