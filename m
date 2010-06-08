Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39696B7D4A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Jun 2010 23:56:17 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o58DnJFb025932
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jun 2010 07:49:19 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o58Du6rQ144944
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jun 2010 07:56:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o58DtvVA017339
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jun 2010 07:55:57 -0600
Date: Tue, 8 Jun 2010 09:55:54 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] powerpc: Fix integer constant warning
Message-ID: <20100608135554.GF7801@zod.rchland.ibm.com>
References: <20100607203957.23695.97675.sendpatchset@squad5-lp1.lab.bos.redhat.com>
	<9000.1276002746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9000.1276002746@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Steve Best <sfbest@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 08, 2010 at 02:12:26PM +0100, David Howells wrote:
>Steve Best <sfbest@us.ibm.com> wrote:
>
>> -#define KERNELBASE (0xc000000000000000)
>> +#define KERNELBASE (0xc000000000000000ULL)
>
>Is this the right fix?  The code producing the warning is subtracting
>0xc000000000000000 from a 32-bit number:

It might not matter, since Paul sent a patch to remove this file entirely.

josh
