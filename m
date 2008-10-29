Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 49F1FDDEF1
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 08:13:15 +1100 (EST)
Date: Wed, 29 Oct 2008 14:13:12 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH RFC v2] net: add PCINet driver
Message-ID: <20081029211312.GJ12879@ovro.caltech.edu>
References: <20081029202027.GH12879@ovro.caltech.edu>
	<20081029132506.55b93555@extreme>
	<20081029205002.GI12879@ovro.caltech.edu>
	<4908CD96.300@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4908CD96.300@freescale.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2008 at 03:54:46PM -0500, Scott Wood wrote:
> Ira Snyder wrote:
>> I know about this. I was following the example set forth in
>> drivers/net/fs_enet. 
>
> I recommend against that. :-)

Great, now you tell me :)

I'll go ahead change the typedef to a struct. Hopefully some of the
other inspiration I took wasn't too bad. I'm totally open to suggestions
on improvements for this driver.

Ira
