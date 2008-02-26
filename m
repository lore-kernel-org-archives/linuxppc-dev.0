Return-Path: <maynardj@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89B30DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 02:36:59 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1QFaS8o006627
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 10:36:28 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1QFauww207546
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 08:36:56 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1QFatmP023212
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 08:36:55 -0700
Message-ID: <47C43217.6060800@us.ibm.com>
Date: Tue, 26 Feb 2008 09:36:55 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: copy_from_user problem
References: <47C36FBA.1030600@us.ibm.com> <1203994599.15052.84.camel@pasglop>
	<47C426F8.7070203@us.ibm.com> <20080226150138.GD16241@localdomain>
In-Reply-To: <20080226150138.GD16241@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Maynard Johnson wrote:
>> static long lib_addr;
>> module_param(lib_addr, long, 0);
>                          ^^^^
> Should be unsigned long?
Right.  I switched this to 'ulong', but that didn't make a difference in 
my test results.
> 
