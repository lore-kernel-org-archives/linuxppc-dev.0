Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 524BDB7D56
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 04:12:17 +1100 (EST)
Date: Thu, 18 Mar 2010 13:12:12 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node
	to get node pointer
Message-ID: <20100318131212.55bd7689@lappy.seanm.ca>
In-Reply-To: <20100318152238.21082.10985.stgit@angua>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Mar 2010 09:22:39 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> The following structure elements duplicate the information in
> 'struct device.of_node' and so are being eliminated.  This patches
> makes all readers of the following elements use device.of_node
> instead.

Acked-by: Sean MacLennan <smaclennan@pikatech.com>
