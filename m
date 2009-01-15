Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 0D40ADE345
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 09:43:05 +1100 (EST)
Date: Fri, 16 Jan 2009 09:43:04 +1100
From: Simon Horman <horms@verge.net.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 0/5 + 2] kexec updates
Message-ID: <20090115224302.GI9114@verge.net.au>
References: <kexec-29-1.miltonm@bga.com> <20090112062359.GK7337@verge.net.au>
	<db22d11838af3c43c4624a8d2f0b0883@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <db22d11838af3c43c4624a8d2f0b0883@bga.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 13, 2009 at 09:59:08AM -0600, Milton Miller wrote:
> On Jan 12, 2009, at 12:24 AM, Simon Horman wrote:
>> On Fri, Jan 02, 2009 at 02:42:38PM -0600, Milton Miller wrote:
>>> Follwing this mail are 5 patches for kexec userspace and two for the
>>> kernel.  The first fixes an array overflow and the second updates
>>> userspace to the merged 2.6.28 kdump support.  The remaining are
>>> cleanups and warning fixes, including one for the common code.
>>>
>>> The two patchs for the kernel are independent.
>>
>> Hi all,
>>
>> sorry to be a bit slow in responding, this email landed just
>> as I was leaving for a weeks holiday.
>>
>
> No problem, I figured as much.
>
>> The kexec-tools patches seem reasonable to me and I'm happy to merge  
>> what I
>> think are the latest versions - thanks Michael for your review.
>>
>> Milton, here are the Subjects, Dates and Message-Ids of what I have in  
>> my
>> queue.  If you could confirm this or repost that would be great.
>>
>> #1
>> Subject: [PATCH kexec-tools v2] ppc64: always check number of ranges  
>> when adding them
>> Date: Thu, 08 Jan 2009 06:33:50 -0600
>> Message-ID: <1231418030_141769@mercury.realtime.net>
>>
>> #2
>> Subject: [PATCH kexec-tools 2/5] ppc64: update kdump for 2.6.28  
>> relocatable kernel
>> Date: Fri, 02 Jan 2009 15:04:42 -0600
>> Message-Id: <kexec-29-1-2r.miltonm@bga.com>
>>
>> #3
>> Subject: [PATCH kexec-tools 3/5] ppc64: segments may be reordered
>> Date: Fri, 02 Jan 2009 15:04:45 -0600
>> Message-Id: <kexec-29-1-3r.miltonm@bga.com>
>>
>> #4
>> Subject: [PATCH kexec-tools 4/5] ppc64: cleanups
>> Date: Fri, 02 Jan 2009 15:04:48 -0600
>> Message-Id: <kexec-29-1-4r.miltonm@bga.com>
>>
>> #5
>> Subject: [PATCH kexec-tools 5/5] entry wants to be void *
>> Date: Fri, 02 Jan 2009 15:04:51 -0600
>> Message-Id: <kexec-29-1-5r.miltonm@bga.com>
>
> Based on the subjects, yes, those are the lastest versions.
>
> And I assume you saw Mohan's tested message.

Thanks. I've added a "Tested-by: M. Mohan Kumar <mohan@in.ibm.com>" tag
to each of the five patches and applied them.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en
