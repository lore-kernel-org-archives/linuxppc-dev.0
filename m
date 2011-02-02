Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8540CB7128
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 18:48:58 +1100 (EST)
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
Date: Wed, 2 Feb 2011 01:48:45 -0600
Message-Id: <85A99D1E-9B32-4816-91FD-355B325D3F8F@kernel.crashing.org>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 1, 2011, at 12:48 PM, Dave Kleikamp wrote:

> Since other OS's may be running on the other cores don't use tlbivax

Are you guys building SMP kernel for use with AMP?  Just wondering why =
you'd be using tlbivax at all.

- k
