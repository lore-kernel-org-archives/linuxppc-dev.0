Message-ID: <3B3B5933.4050509@mvista.com>
Date: Thu, 28 Jun 2001 09:20:03 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: Michael Habermann <MHabermann@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Segmentation fault while dynamic linking
References: <Pine.LNX.3.95.1010628024351.5112B-100000@november.bhjjh.erols.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Justin (Gus) Hurwitz wrote:

> On Thu, 28 Jun 2001, Michael Habermann wrote:
>
>
>>At 10:08 AM 6/27/2001 -0700, Matthew Locke wrote:
>>
>>
>>>There are two places cacheline size affects glibc.  The one above that
>>>you already found and in the glibc ppc optimized memset or memcpy (don't
>>>remember which one).  you can just delete the ppc specific memset and
>>>configure will pull in the generic memset.
>>>
>>Yeah, deleting memset.S solved my problem.
>>
>>Thanks to you and the guys who answered by private mail.
>>
>
> Could you post a quick summary of what yo had to do to get this to work
> (ie, which source you downloaded, which patches you downloaded and
> applied, and which flags you used to compile)?
>
> I've been trying to get uClibc to work, but am having IO errors with it,
> so I'm thinking of giving glibc another try.
>


that is probably best:-)  Just grab our toolchain it works and it has
the patches in its src rpm.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
