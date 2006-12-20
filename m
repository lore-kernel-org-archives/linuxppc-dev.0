Return-Path: <cjashfor@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC76CDE05F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 07:34:22 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBKKYJ7g010303
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 15:34:19 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBKKYHoo543140
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 13:34:17 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBKKYHnt008021
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 13:34:17 -0700
Received: from [127.0.0.1] (rational-corey.beaverton.ibm.com [9.47.21.171])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kBKKYFr1007864
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 13:34:17 -0700
Message-ID: <45899E47.30704@us.ibm.com>
Date: Wed, 20 Dec 2006 12:34:15 -0800
From: Corey Ashford <cjashfor@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: New PowerPC-specific Eclipse CDT plugin for Eclipse needs a home
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: cjashfor@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm new to this mailing list (and the penguinppc web site).  I've just 
finished up a first version of a PowerPC-specific plug-in for the 
Eclipse C/C++ Development Tooling plug-in.

This plug-in adds most of the PowerPC specific GNU C/C++ compiler 
switches, as well as switches needed for the assembler and for linking 
(using gcc).

At this point, eclipse.org will not host it as they do not have 
target-specific plug-ins yet.  They may eventually.

In the meantime, I'm looking for a place to host this plug-in and would 
be interested in getting some feedback on the content and quality of it, 
because this is first cut.

Thanks for your consideration,

- Corey

-- 
Corey Ashford
Software Engineer
IBM Linux Technology Center, Linux Toolchain
Beaverton, OR
503-578-3507
cjashfor@us.ibm.com
