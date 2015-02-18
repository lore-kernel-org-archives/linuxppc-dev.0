Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DCEEC1A09D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 17:20:11 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 23:20:09 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 507C119D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 23:11:15 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1I6KGaw46006274
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 23:20:24 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1I6JXlm017304
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 23:19:33 -0700
Message-ID: <54E42EAF.1080609@linux.vnet.ibm.com>
Date: Wed, 18 Feb 2015 11:48:23 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
References: <20150203061709.13097.7035.stgit@preeti.in.ibm.com>
 <4031451.QMQakQrpsN@vostro.rjw.lan> <54E4186B.40605@linux.vnet.ibm.com>
 <3335960.mm4nUDCbyI@vostro.rjw.lan>
In-Reply-To: <3335960.mm4nUDCbyI@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Cc: stewart@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/18/2015 11:21 AM, Rafael J. Wysocki wrote:
> On Wednesday, February 18, 2015 10:13:23 AM Preeti U Murthy wrote:
>>
>> On 02/17/2015 11:23 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, February 17, 2015 01:29:10 PM Preeti U Murthy wrote:
>>>> Hi Rafael,
>>>
>>> Hi,
>>>
>>>> Can you please pull this patch ?
>>>
>>> Sorry, I wasn't sure whether or not the patch was for me to take and then
>>> I've been traveling lately.  Applied now.
>>
>> Hi Rafael,
>>
>> I saw that the kbuild bot reported build issues around pr_warn() in this patch.
>> I have fixed this and below is the corrected patch. Do let me know if I have
>> to send it out as a separate version/RESEND tag.
> 
> I've applied it, thanks!
> 
>>>> Another patch based on top of this is waiting to be pulled:
>>>> [PATCH] driver/cpuidle-powernv: Avoid endianness conversions while parsing DT
>>>
>>> OK, have you posted it already?
>> Yes I have. https://lkml.org/lkml/2015/2/3/24.
> 
> OK, so this one does not apply for me on top of the other.  Can you rebase it
> on top of my current linux-next branch and resend it, please?
> 
> Also I'd appreciate it if someone could ACK DT-related stuff for me.

Yes Ill get this done.
> 
>> This patch is also waiting to be pulled by you. There was some confusion
>> around who should pull this, but since it all the code is in the driver, we
>> thought it would be best if you pulled it.
> 
> Well, OK.  If you want me to apply a patch, send it To: me and not To: someone
> else.  If you send it To: someone else, I'll ignore it.
> 
> Also ask people to review and ACK things you want me to pull, especially if
> that's not stuff I'm particularly familiar with (like related to DT bindings
> specific to your platform etc.).
> 

Sure Ill do that. Thanks!

Regards
Preeti U Murthy
> 
