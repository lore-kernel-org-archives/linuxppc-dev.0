Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 82118B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 13:35:34 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Sat, 10 Dec 2011 08:05:29 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBA2ZPd02519242
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 08:05:26 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBA2ZPO9014711
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 08:05:25 +0530
Message-ID: <4EE2C56B.2000306@in.ibm.com>
Date: Sat, 10 Dec 2011 08:05:23 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH v4 3/7] [ppc] Process dynamic relocations for kernel
References: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
 <20111209114720.16360.9670.stgit@suzukikp.in.ibm.com>
 <CA+5PVA7+73myrEGDUjuYrc2D-MabCefehpV+ynpOPFi=hLRMEA@mail.gmail.com>
In-Reply-To: <CA+5PVA7+73myrEGDUjuYrc2D-MabCefehpV+ynpOPFi=hLRMEA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/11 19:10, Josh Boyer wrote:
> On Fri, Dec 9, 2011 at 6:47 AM, Suzuki K. Poulose<suzuki@in.ibm.com>  wrote:
>>
>> Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
>> Signed-off-by: Josh Poimboeuf<jpoimboe@linux.vnet.ibm.com>
>> Cc: Paul Mackerras<paulus@samba.org>
>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Cc: Alan Modra<amodra@au1.ibm.com>
>> Cc: Kumar Gala<galak@kernel.crashing.org>
>> Cc: linuxppc-dev<linuxppc-dev@lists.ozlabs.org>
>> ---
>>
>>   arch/powerpc/Kconfig              |   42 ++++++++++++++++++++++---------------
>>   arch/powerpc/Makefile             |    6 +++--
>>   arch/powerpc/kernel/Makefile      |    2 ++
>>   arch/powerpc/kernel/vmlinux.lds.S |    8 ++++++-
>>   arch/powerpc/relocs_check.pl      |    7 ++++++
>>   5 files changed, 44 insertions(+), 21 deletions(-)
>
> You're missing the whole reloc_32.S file in this patch.  Forget to do a git-add?
>
> Can you resend just this patch with that fixed up?

Yikes, missed that. Will send the updated one.

Thanks
Suzuki
>
> josh
>
