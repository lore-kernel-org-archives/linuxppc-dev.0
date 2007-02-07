Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12235DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 15:37:39 +1100 (EST)
In-Reply-To: <20070207032907.GE23870@localhost.localdomain>
References: <20070207032907.GE23870@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <702B18C7-8F8F-4920-8014-236BA5BBF190@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [dtc] Allow references to labels
Date: Tue, 6 Feb 2007 22:36:45 -0600
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 9:29 PM, David Gibson wrote:

> dtc allows nodes to have labels, which at present are just re-emitted
> as symbols at the appropriate places when using asm-mode output.  It
> also allows "references" where the notation &/path/to/node in a cell
> list will be replaced with the phandle of the referenced node.
>
> This patch extends the reference syntax to allow references to labels
> instead of just full device paths.  This allows nodes deep within the
> tree to be referenced with a shorter more convenient name.  References
> to labels are distinguished from reference to paths by the fact that
> paths must start with a /, but labels can never start with a /.
>
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Mind adding an example of this to the testsuite?

- k
