Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kp.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A6FF5DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 08:01:13 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	m47M16X22939
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 22:01:06 GMT
Message-ID: <4822269E.60304@nortel.com>
Date: Wed, 07 May 2008 16:01:02 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: error building 2.6.25 for G5 -- current git head affected as well
References: <48221A5F.6020306@nortel.com>
In-Reply-To: <48221A5F.6020306@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen wrote:
> Hi,
> 
> I'm getting the following error when building 2.6.25.  Has anyone else 
> seen anything like this?  This is using gcc 3.4.3.

> BFD: arch/powerpc/kernel/vdso64/vdso64.so: The first section in the 
> PT_DYNAMIC segment is not the .dynamic section
> /home/cfriesen/bin/ppc64-R9a/bin/ppc64-R9a-objcopy: 
> arch/powerpc/kernel/vdso64/vdso64.so: Bad value


I just verified that current git head shows the same problem.  Binutils 
version is 2.15.92.0.2, is this too old?

Chris
