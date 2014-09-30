Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 30F991A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 23:53:11 +1000 (EST)
Message-ID: <542AB5D0.3080007@arm.com>
Date: Tue, 30 Sep 2014 14:53:20 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 04/11] drivers: base: support cpu cache information
 interface to userspace via sysfs
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com>
 <1409763617-17074-5-git-send-email-sudeep.holla@arm.com>
 <5419C3F6.4050607@arm.com> <20140917190048.GA4063@kroah.com>
 <20140924063511.GA12929@kroah.com>
In-Reply-To: <20140924063511.GA12929@kroah.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Greg,

On 24/09/14 07:35, Greg Kroah-Hartman wrote:
> On Wed, Sep 17, 2014 at 12:00:48PM -0700, Greg Kroah-Hartman wrote:
>> On Wed, Sep 17, 2014 at 06:25:10PM +0100, Sudeep Holla wrote:
>>> Hi Greg,
>>>
>>> On 03/09/14 18:00, Sudeep Holla wrote:

[...]
>>>
>>> Can you review the first 4 patches in this series please ?
>>
>> It's in my todo queue, which is really long at the moment due to me
>> going to conferences (at one right now...)  Will be working on this
>> soon, thanks for your patience.
>
> Based on the review comments, I think you are going to change at least
> the first patch, right?  Please resend the latest version of this
> series, with all of the accumulated tested-by and acked lines and
> resend.
>

I have posted the new version as you suggested. I was holding off
assuming the merge window would open this week and hence the delay.

Regards,
Sudeep
