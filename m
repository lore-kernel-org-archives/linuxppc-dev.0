Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E90D8B70E5
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2011 10:14:03 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id p24NE17J004592
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 10:14:01 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p24NE1Ql2195464
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 10:14:01 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p24NE0YK001778
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 10:14:00 +1100
Subject: Re: [PATCH v4 2/2] add icswx support
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1299280053.28840.96.camel@flin.austin.ibm.com>
References: <1299086454.28840.10.camel@flin.austin.ibm.com>
	<1299200560.8833.869.camel@pasglop>
	<1299259794.28840.57.camel@flin.austin.ibm.com>
	<1299270417.8833.897.camel@pasglop>
	<1299277344.28840.79.camel@flin.austin.ibm.com>
	<1299278441.8833.915.camel@pasglop>
	<1299280053.28840.96.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 05 Mar 2011 10:13:59 +1100
Message-ID: <1299280439.8833.918.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-04 at 17:07 -0600, Tseng-Hui (Frank) Lin wrote:
> I don't have any measurable numbers. That's why I made it an option in
> case people wants to disable it. I do agree that the kernel has so many
> options that we should refrain from adding more. If the chance that the
> lazy switching slows down the execution is really low, we should just
> take out the option. Is there any one has an idea how much the numbers
> are? 

Well, per-cpu loads are notoriously inefficient due to nasty codegen,
but often cache hot as well, I wouldn't worry too much. Just remove the
option for now. We can always add it back if it ever becomes desirable,
but I very much doubt it.

Cheers,
Ben.
