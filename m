Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <46713999.2080004@ru.mvista.com>
Date: Thu, 14 Jun 2007 16:50:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
In-Reply-To: <20070612044246.GC4198@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

David Gibson wrote:

> So, what you're suggesting is a subnode for each described partition?
> Seems an awfully verbose way of going about it, and I don't see what
> it buys us over the partitions/partition-names pair of properties.

    I was thinking of using a signle multipart prop but dtc had no support for 
it at that time...

WBR, Sergei
