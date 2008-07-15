Return-Path: <srinivasa@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56152DDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:30:33 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6FATteY016116
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:29:55 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6FAUWkP203236
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:30:32 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6FAUVpo025523
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:30:32 +1000
Message-ID: <487C7C48.8090308@in.ibm.com>
Date: Tue, 15 Jul 2008 16:00:32 +0530
From: Srinivasa DS <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
References: <200807071952.27427.srinivasa@in.ibm.com>
	<200807141401.26917.srinivasa@in.ibm.com>
	<1216026417.7549.270.camel@pasglop>
	<200807151436.55912.srinivasa@in.ibm.com>
	<1216113357.7740.95.camel@pasglop>
In-Reply-To: <1216113357.7740.95.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-15 at 14:36 +0530, Srinivasa D S wrote:
>> On Monday 14 July 2008 02:36:57 pm Benjamin Herrenschmidt wrote:
>>
>>>> Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
>>> Can you send a cleanup patch against powerpc.git instead ?
>>>
>> Resending the patch against powerpc.git tree.
> 
> Nah, your initial patch is there already :-) I'm just asking for a
> cleanup one that removes the useless cast.
> 

Sorry, I got it wrong, But I dont find my patch in your latest powerpc 
git tree(git.kernel.org/?p=linux/kernel/git/benh/powerpc.git).

Thanks
  Srinivasa DS
