Return-Path: <kniht@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 350AFDDF82
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:30:46 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBAMTF4i015451
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:29:15 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBAMUhiR162996
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:30:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBAMUgxn005896
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:30:43 -0700
Message-ID: <49404311.1000701@us.ibm.com>
Date: Wed, 10 Dec 2008 16:30:41 -0600
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/8] fix bootmem reservation on uninitialized node
References: <20081209182130.DB2150A2@kernel> <20081209182130.1E4C1438@kernel>
	<18752.16188.480990.923571@cargo.ozlabs.ibm.com>
In-Reply-To: <18752.16188.480990.923571@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	"Serge E. Hallyn" <serue@us.ibm.com>
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Dave Hansen writes:
>
>   
>> This patch ensures that we do not touch bootmem for any node which
>> has not been initialized.
>>
>> Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
>>     
>
> So, should I be sending this to Linus for 2.6.28?
>
> I notice you have added a dbg() call.  For a 2.6.28 patch I'd somewhat
> prefer not to have that in unless necessary.
>
> Jon, does this patch fix the problem on your machine with 16G pages?
>   
It worked on a machine with one page, I am awaiting access to another 
with more pages.

> Paul.
>   
Jon
