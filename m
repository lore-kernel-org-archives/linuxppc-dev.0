Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 6BD4767A6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 02:44:12 +1000 (EST)
Message-ID: <4252C04A.8020407@nortel.com>
Date: Tue, 05 Apr 2005 10:43:54 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Fillod Stephane <stephane.fillod@thomson.net>
References: <1CFEB358338412458B21FAA0D78FE86D4F0D2D@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D2D@rennsmail02.eu.thmulti.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: somewhat OT -- trying to build code on the fly then run it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fillod Stephane wrote:
> Chris Friesen wrote: 
> 
>>I'm writing a testcase to test some code we wrote to allow userspace
> to flush the whole dcache and invalidate the whole icache.  
> 
> 
> Your testcase sounds like this kernel module for RT load generator:
> 
> 	http://rtai.dk/cgi-bin/gratiswiki.pl?Latency_Killer/Flushy

Unfortunately that code calls flush_instruction_cache(), which doesn't 
work on the 970 in the ppc tree, and doesn't even exist anymore in the 
ppc64 tree.

Chris
