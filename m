Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id EB909679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 23:47:26 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4JDq9wR001197
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 16:52:17 +0300 (EEST)
Message-ID: <428C9338.9040403@intracom.gr>
Date: Thu, 19 May 2005 16:23:04 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: jmasel@arabellasw.com
References: <E1DYPVW-0000vS-00@gold.webfusion.co.uk>
In-Reply-To: <E1DYPVW-0000vS-00@gold.webfusion.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: 'PPC_LINUX' <linuxppc-embedded@ozlabs.org>
Subject: Re: Arabella Resource Manager
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jonathan Masel wrote:
> Hi all,
> Several people have expressed an interest in seeing some more of our
> Resource Manager - a kernel library for allocating/releasing on-chip
> resources of all PQ processors. We currently have PQ1, PQ2 and PQ3 for 2.4
> and 2.6 kernels.
> 
[snip]
> 
> 

Jonathan, I see that you use a proc interface for status.
You could use the seq_file abstraction and clean up the code there.

Also could you just list the categories of the thing you manage
on the list so that we can comment per category?

Regards

Pantelis
