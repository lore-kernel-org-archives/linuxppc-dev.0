Return-Path: <jimix@watson.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFDF867D50
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 14:50:07 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.boulder.ibm.com [9.17.249.41])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3D2FgcX002718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 22:15:42 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3D2FcR2029799
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 22:15:38 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3D2C8YY257868
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 20:12:08 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3D2FZa9019563
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 20:15:35 -0600
In-Reply-To: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
Date: Wed, 12 Apr 2006 22:15:40 -0400
To: Jimi Xenidis <jimix@watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2006, at 10:05 PM, Jimi Xenidis wrote:
>
> NOTE: that the dtc must also not generate the blob reservation
> entry.

This reservation is only generated for "asm" dtc targets so it is  
only that case that need to be changed.

>   Should we try to detect this redundant entry? Should we bump
> the DT version number?

-JX
