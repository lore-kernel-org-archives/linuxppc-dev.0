Message-ID: <40B72F90.1000004@intracom.gr>
Date: Fri, 28 May 2004 15:24:48 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: rdiz@alumni.deec.uc.pt
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.6-7-rc1 8xx - No go
References: <40B6FAFB.8020803@intracom.gr> <40B711A6.1080603@intracom.gr> <4517.62.48.238.11.1085744283.squirrel@alumni.deec.uc.pt>
In-Reply-To: <4517.62.48.238.11.1085744283.squirrel@alumni.deec.uc.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


rdiz@alumni.deec.uc.pt wrote:

>Did you actually manage to compile standard (no tweak), 2.6.7-rc1 for 8xx?
>If so, what '8xx Machine Type' did you chose?
>
>
>Regards,
>Ricardo Diz
>
>
>>Pantelis Antoniou wrote:
>>
>>
>>>Hi there.
>>>
>>>I'm reporting that my tree, after updating from 2.6.6 -> 2.6.7-rc1
>>>does not work any more.
>>>
>>>Currently investigating why.
>>>
>>>Regards
>>>
>>>Pantelis
>>>
>>>
>>>
>>Update; for some reason the problem seems to be that page faults
>>are incredibly slow.
>>
>>Starting a dummy init after a minute it manages to start and operate
>>correctly.
>>
>>I suspect a terribly slow page fault.
>>
>>Regards
>>
>>Pantelis
>>
>>
>>
>>
>>
>
>
>
>
>
>
It's the linuxppc-2.5 tree. Plus my own modifications.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
