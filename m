Return-Path: <aik@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED9881007DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Mar 2011 17:15:03 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p2269u5w023789
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2011 17:09:56 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p226F28U2261048
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2011 17:15:02 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p226F2m8020912
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2011 17:15:02 +1100
Message-ID: <4D6DE074.5050802@au1.ibm.com>
Date: Wed, 02 Mar 2011 17:15:16 +1100
From: Alexey Kardashevskiy <aik@au1.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Per process DSCR + somefixes (try#3)
References: <4D5B62F2.3020709@au1.ibm.com> <1299044868.8833.832.camel@pasglop>
In-Reply-To: <1299044868.8833.832.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/03/11 16:47, Benjamin Herrenschmidt wrote:
> BTW. I suppose it's an expected behaviour that thread created with a
> given default value will keep that value even when the default is later
> changed right ? And their descendents will use the same default as the
> original thread, not the new default, at least that's how I read your
> code :-) Maybe that should be documented somewhere...
>    

That's right. The idea was to let one set of 
processes-which-do-not-access-dscr-directly to work+fork with one value 
and other set to work+fork with another value. I have no idea who and 
how is going to use it though. Hope the HPC team tells me if something 
is wrong :-)

-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail/sametime: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM
