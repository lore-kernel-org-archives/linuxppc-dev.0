Return-Path: <nfont@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 27AE11007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 12:28:18 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6D2LHPG029941
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 20:21:18 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o6D2SFai163286
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 20:28:15 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6D2SFPO009573
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 20:28:15 -0600
Message-ID: <4C3BCF3E.7060000@austin.ibm.com>
Date: Mon, 12 Jul 2010 21:28:14 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: 7eggert@gmx.de
Subject: Re: [PATCH 0/7] De-couple sysfs memory directories from memory
	sections
References: <f5t7d-2ZJ-23@gated-at.bofh.it>
	<20100712194958.1A32B2D6595@mail-in-10.arcor-online.net>
In-Reply-To: <20100712194958.1A32B2D6595@mail-in-10.arcor-online.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bodo Eggert <7eggert@web.de>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/2010 02:30 PM, Bodo Eggert wrote:
> Nathan Fontenot <nfont@austin.ibm.com> wrote:
> 
>> The file 'split' allows for splitting the
>> directory in two, with each new directory covering half as many
>> memory sections as the previous directory.
> 
> Just some random thoughts:
> 1) Why is it needed/helpful?

This is needed if someone needed to perform an action (add/remove) a
single memory section. The 'split' option allows users to isolate
a memory section  so these operations could be performed.

> 2) If it is needed, why not take an int to split after n entries?

The idea of being able to split a directory came out of a previous
discussion on how to resolve the issue this patch set is trying to solve.
I included the split functionality in this patch set since it
was suggested.  I will leave the decision of whether or not this
functionality is needed up to the community.

-Nathan 
