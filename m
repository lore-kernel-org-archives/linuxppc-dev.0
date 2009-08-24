Return-Path: <amwang@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3E235B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 12:37:03 +1000 (EST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 3842CDDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 12:37:01 +1000 (EST)
Message-ID: <4A91EE3D.7050805@redhat.com>
Date: Mon, 24 Aug 2009 09:34:53 +0800
From: Amerigo Wang <amwang@redhat.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Patch 0/8] V4 Implement crashkernel=auto
References: <20090821065637.4855.32234.sendpatchset@localhost.localdomain>
	<20090821170615.1ea4a4f4.akpm@linux-foundation.org>
In-Reply-To: <20090821170615.1ea4a4f4.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: fenghua.yu@intel.com, nhorman@redhat.com, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, andi@firstfloor.org,
	ebiederm@xmission.com, mingo@elte.hu, bernhard.walle@gmx.de,
	kamezawa.hiroyu@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> (cc linuxppc-dev@ozlabs.org)
>
> On Fri, 21 Aug 2009 02:54:12 -0400
> Amerigo Wang <amwang@redhat.com> wrote:
>
>   
>> This series of patch implements automatically reserved memory for crashkernel,
>> by introducing a new boot option "crashkernel=auto". This idea is from Neil.
>>
>> In case of breaking user-space applications, it modifies this boot option after
>> it decides how much memory should be reserved.
>>
>> On different arch, the threshold and reserved memory size is different. Please
>> refer patch 8/8 which contains an update for the documentation.
>>
>> Patch 1/8 implements shrinking reserved memory at run-time, which is useful
>> when more than enough memory is reserved automatically.
>>
>> Note: This patchset was only tested on x86_64 with differernt memory sizes.
>>     
>
>
> I'd prefer that this change had been runtime tested on ia64 and powerpc
> and has had some quality review from relevant developers of those
> architectures.
>
> Looking at the cc's, I'm not sure that the powerpc guys even know about
> this work?
>
>   
Ok, let me try to find some ppc and ia64 machines in the company.. ;)
