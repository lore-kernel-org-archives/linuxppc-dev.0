Return-Path: <walkinair@cn.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01BF667C18
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 02:15:18 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id k9HGOo6K238014
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 02:24:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9HGIR6q236208
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 02:18:32 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9HGF19G025796
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 02:15:02 +1000
Message-ID: <45350182.8030801@cn.ibm.com>
Date: Wed, 18 Oct 2006 00:14:58 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [Regression] cpu hotplug failed on kernel 2.6.19-rc2
References: <4534D7C6.2080402@cn.ibm.com> <20061017161251.GB18689@localdomain>
In-Reply-To: <20061017161251.GB18689@localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch 写道:
> Yao Fei Zhu wrote:
> 
> 
>>Running cpu hotplug regression tsstcase lhcs_regression on kernel
>>2.6.19-rc2/IBM System p5 will fall into xmon.
> 
> 
> Your subject implies this is a regression; what is the most recent
> kernel that worked?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
2.6.18 works. Not tested on 2.6.19-rc1.
