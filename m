Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1C63B7105
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 04:18:57 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8SI3lKZ005551
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 14:03:47 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8SIItNK400208
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 14:18:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8SIIr76023610
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 15:18:54 -0300
Message-ID: <4CA23185.2060905@austin.ibm.com>
Date: Tue, 28 Sep 2010 13:18:45 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 8/8] v2 Update memory hotplug documentation
References: <4CA0EBEB.1030204@austin.ibm.com>
	<4CA0F076.1070803@austin.ibm.com> <4CA1E36A.2000005@redhat.com>
In-Reply-To: <4CA1E36A.2000005@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2010 07:45 AM, Avi Kivity wrote:
>  On 09/27/2010 09:28 PM, Nathan Fontenot wrote:
>>
>>   For example, assume 1GiB section size. A device for a memory
>> starting at
>>   0x100000000 is /sys/device/system/memory/memory4
>>   (0x100000000 / 1Gib = 4)
>>   This device covers address range [0x100000000 ... 0x140000000)
>>
>> -Under each section, you can see 4 files.
>> +Under each section, you can see 5 files.
> 
> Shouldn't this be, 4 or 5 files depending on kernel version?
> 

Correct,  I'll update this.  Thanks.

-Nathan
