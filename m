Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CFACB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 16:43:54 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 15 Mar 2012 11:13:48 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2F5hisx3834060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 11:13:44 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2FBECXt026507
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 22:14:12 +1100
Message-ID: <4F61818D.9020103@in.ibm.com>
Date: Thu, 15 Mar 2012 11:13:41 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 0/2] Kdump support for PPC_47x
References: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
 <CA+5PVA4MdztrCk1QyiAZLit-2s807D85mrdmjA4w3gJjn=5p1w@mail.gmail.com>
In-Reply-To: <CA+5PVA4MdztrCk1QyiAZLit-2s807D85mrdmjA4w3gJjn=5p1w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/15/2012 12:27 AM, Josh Boyer wrote:
> On Wed, Mar 14, 2012 at 6:22 AM, Suzuki K. Poulose<suzuki@in.ibm.com>  wrote:
>> The following series implements Kexec/Kdump support for
>> PPC_47x based platforms. Doesn't support SMP yet.
>>
>> I have tested these patches on simics simulator for ppc476.
>
> Do you happen to know if these work in the IBM Instruction Set Simulator for
> 47x?  That would be the only commonly available 476 platform that I'm aware
> of.
I haven't tested it on IBM ISS for 47x. However the code is similar that 
we have in the boot map setup. I will see if I can get access to one and 
test it there.

Thanks
Suzuki
