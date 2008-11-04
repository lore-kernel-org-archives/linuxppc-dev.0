Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3E8EDE067
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 08:33:07 +1100 (EST)
Date: Tue, 4 Nov 2008 13:32:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1 v2] powerpc: hugetlb pgtable cache access cleanup
Message-Id: <20081104133231.fb224e68.akpm@linux-foundation.org>
In-Reply-To: <490A2F4D.7030908@linux.vnet.ibm.com>
References: <490A2F4D.7030908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: nickpiggin@yahoo.com.au, kniht@linux.vnet.ibm.com, dwg@au1.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Oct 2008 17:03:57 -0500
Jon Tollefson <kniht@linux.vnet.ibm.com> wrote:

> It was suggested by Andrew that using a macro that made an array
> look like a function call made it harder to understand the code.
> Cleaned up use of macro.  We now reference the pgtable_cache array
> directly instead of using a macro.  

I felt compelled to apply this.  See http://en.wikipedia.org/wiki/Sunk_costs
to see why I am an irrational actor.
