Return-Path: <maynardj@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4054DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:34:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6ALSUi2005328
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 17:28:30 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6ALXr3f243234
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:33:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6ALXph7010936
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:33:53 -0600
Message-ID: <4693FB3C.4060305@us.ibm.com>
Date: Tue, 10 Jul 2007 16:33:48 -0500
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: willschm@linux.vnet.ibm.com
Subject: Re: Resend: [PATCH] oprofile support for Power 5++
References: <4693CC5B.4020207@linux.vnet.ibm.com>
	<14287.1184096639@neuling.org>
	<4693E7EF.4020708@linux.vnet.ibm.com> <911.1184099498@neuling.org>
	<1184101660.22547.104.camel@farscape.rchland.ibm.com>
In-Reply-To: <1184101660.22547.104.camel@farscape.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	mjw@linux.vnet.ibm.com
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt wrote:

> On Tue, 2007-07-10 at 15:31 -0500, Michael Neuling wrote:
> 
>>>>Does it make more sense to call this "ppc64/power5+rev3"?  
>>>>  
>>>
>>>This is a change to support new counter setup for oprofile.  It may be the
>>>same if there is a revision 4 or 5 etc.  So since the internal name was ++
I have no idea if there will be a revision 4, etc, but I'm assuming the 
behavior would be the same as rev 3.  So I'm not in favor of changing 
this string to include "rev3" in it.  But whatever decision is made, I 
hope it can be made soon.  The OProfile community is testing a release 
candidate right now that includes the userspace portion of this issue 
which checks for the string "ppc64/power5++".  We hope to GA this next 
oprofile release very soon.

Thanks.
-Maynard
>>>I followed that convention. 
> 
> 
> There is an oprofile change already made, or in-flight, or at least
> submitted, that will be looking for the "power5++" string, so if the
> string changes here, it'll need to be changed there too. 
> 
> ( http://article.gmane.org/gmane.linux.oprofile/4670 )
> 
> 
>>I'm not too fussed, but if rev 4 comes out, the counters change and we
>>need power5+++, it's gonna look pretty silly :-)
> 
> 
> silly, but would be funny to see.  :-) 
> 
> 
>>Mikey
>>_______________________________________________
>>Linuxppc-dev mailing list
>>Linuxppc-dev@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
