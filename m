Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id 8742067A76
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 19:25:26 +1100 (EST)
Date: Mon, 7 Mar 2005 09:25:20 +0100
From: Domen Puncer <domen@coderock.org>
To: Joerg Dorchain <joerg@dorchain.net>
Message-ID: <20050307082520.GA18117@nd47.coderock.org>
References: <20050306222256.A3F911F1FF@trashy.coderock.org>
	<20050307073721.GB15637@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050307073721.GB15637@Redstar.dorchain.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [patch 1/4] delete unused file arch_ppc_kernel_find_name.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 07/03/05 08:37 +0100, Joerg Dorchain wrote:
> On Sun, Mar 06, 2005 at 11:22:56PM +0100, domen@coderock.org wrote:
> > Remove nowhere referenced file. (egrep "filename\." didn't find anything)
> 
> To me it looks more like a devloper aid than a kernel file. Ok, it
> functionality could be replaced by a grep -C, but really delete it?

I believe every kernel developer has grep :-)
Or maybe it could be moved to scripts/ or somewhere?


	Domen
