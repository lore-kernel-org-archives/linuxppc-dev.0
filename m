Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE661B7043
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 19:49:38 +1000 (EST)
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4ABC86E0.9090807@kernel.org>
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>
	<4ABB6D33.6060706@kernel.org>  <4ABB72BD.9050905@in.ibm.com>
	<1253826309.7103.461.camel@pasglop> <4ABC376D.1020704@kernel.org>
	<4ABC6E25.7090904@in.ibm.com> <4ABC73C7.20403@kernel.org>
	<4ABC7486.8040500@kernel.org> <4ABC7955.2070404@in.ibm.com>
	<4ABC86E0.9090807@kernel.org>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 19:48:31 +1000
Message-Id: <1253872111.7103.520.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-25 at 18:01 +0900, Tejun Heo wrote:
> > With this patch applied the machine boots OK :-)
> 
> Ah... so, the problem really is too high address.  If you've got some
> time, it might be interesting to find out how far high is safe.
> 
Might give me a clue about what the problem is but I think I'll just
cook up a test case that forcibly vmap something high up and see how it
goes from there. It could be a very old bug that nobody ever noticed
because our vmalloc space on 64-bit is so huge :-)

Cheers,
Ben.
