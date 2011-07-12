Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DF64B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 23:27:14 +1000 (EST)
Received: by vxb40 with SMTP id 40so3806349vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 06:27:11 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <4E12ACD2.9050305@in.ibm.com>
References: <20110705043657.GF13483@ozlabs.org> <4E12ACD2.9050305@in.ibm.com>
Date: Tue, 12 Jul 2011 09:27:11 -0400
Message-ID: <CA+5PVA6d9=PfsFbbFKyNSu6a+pUd0=ZBFVXzUYAYmg3hd5poXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc/47x: allow kernel to be loaded in higher
	physical memory
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 5, 2011 at 2:18 AM, Suzuki Poulose <suzuki@in.ibm.com> wrote:
> On 07/05/11 10:06, Tony Breeds wrote:
>>
>> From: Dave Kleikamp<shaggy@linux.vnet.ibm.com>
>>
>> The 44x code (which is shared by 47x) assumes the available physical
>> memory
>> begins at 0x00000000. =A0This is not necessarily the case in an AMP
>> environment.
>>
>> Support CONFIG_RELOCATABLE for 476 in order to allow the kernel to be
>> loaded into a higher memory range.
>
> I think the code assumes, the kernel is loaded in 256M aligned page. You =
may
> want to mention that in the description here.

Suzie, do you have any other concerns with this code in regards to
your kexec/kdump work for 4xx?  It seems fairly self-contained to me,
so I'd like to apply it but I want to make sure it is not going to
majorly conflict with the work you're doing.

josh
