Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DD1ADB71EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 19:28:42 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42F1BDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 19:28:41 +1000 (EST)
Subject: Re: 2.6.30-git3 boot failure on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A3219B0.3040308@in.ibm.com>
References: <4A3219B0.3040308@in.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 19:28:26 +1000
Message-Id: <1244798906.7172.103.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-12 at 14:32 +0530, Sachin Sant wrote:
> 2.6.30-git3 fails to boot on Power6 box with following messages

 .../...

> git2 boots fine with the same config. 
> 
> I came across the following mail from Ben so this could be a know issue.
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073102.html

Thanks. Yes it's a known issue, I'm working with Pekka to find the right
solution.

Cheers,
Ben.
