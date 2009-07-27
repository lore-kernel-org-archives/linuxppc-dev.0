Return-Path: <cndougla@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A8633B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 12:23:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6R2NVcx017939
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2009 22:23:31 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6R2NcCN210686
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2009 22:23:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6R2NcWT019620
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2009 22:23:38 -0400
Message-Id: <87B65A66-572B-442E-88C6-872F23DF39D4@linux.vnet.ibm.com>
From: Chase Douglas <cndougla@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1248655033.28464.26.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc: Add compat_sys_truncate
Date: Sun, 26 Jul 2009 22:23:37 -0400
References: <8349EEAE-34B9-4D7E-837F-1320057E59D2@linux.vnet.ibm.com>
	<1248655033.28464.26.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Jul 26, 2009, at 8:37 PM, Benjamin Herrenschmidt wrote:
> Unfortunately, your patch have been mangled by your mailer
> our your mail gateway in about every possible way (word
> wrapped, tabs and whitespace damaged etc...)

Sorry about that! I made sure my mailer (OS X's Mail) sent it as plain  
text, but I don't know of any settings for specifying line width or  
white space handling. I'll have to do some more digging or use a  
different mailer for patches.

Thanks,
Chase
