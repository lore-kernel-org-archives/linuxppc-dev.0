Return-Path: <jschopp@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2200DE254
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 05:18:30 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9AIIQOu002596
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:18:26 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9AIIQ3j103800
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 12:18:26 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9AIIQxf015359
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 12:18:26 -0600
Message-ID: <48EF9C71.9000009@austin.ibm.com>
Date: Fri, 10 Oct 2008 13:18:25 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH/RFC] 64 bit csum_partial_copy_generic
References: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
	<18670.62070.659790.67023@drongo.ozlabs.ibm.com>
In-Reply-To: <18670.62070.659790.67023@drongo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, fulkgl@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Thanks for doing this.  A few comments below, but first, can you
> clarify what your and George Fulk's roles were in producing this?  I had
> the impression George had written the code, and if that's the case,
> you need to put a "From: George Fulk <...>" line as the first line of
> your mail when you re-send the patch.
>   
I wrote the patch, George wrote some very useful testcases.  So a 
Tested-by: George Fulk <fulkgl@us.ibm.com> line would be appropriate, 
not sure if that line ever really caught on.

As for the technical comments, I agree with all of them and will 
incorporate them into the next version.
