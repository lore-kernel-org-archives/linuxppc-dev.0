Message-ID: <4070F71C.80201@intracom.gr>
Date: Mon, 05 Apr 2004 09:05:16 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [OT?] Unimplemented instructions on a G5?
References: <406C1E50.1010806@intracom.gr>  <EC443756-84BA-11D8-89ED-000A95A4DC02@kernel.crashing.org> <200404021549.i32FnZT35302@makai.watson.ibm.com>
In-Reply-To: <200404021549.i32FnZT35302@makai.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:

>>>The offending instruction is the seemingly harmless:
>>>
>>>mcrxr crX
>>>
>>>(Move to condition register from XER).
>>>
>>>Does anyone have any idea if IBM left this instruction
>>>unimplemented. Searching the docs I've found nothing.
>>>
>>>
>
>
>
>>>>>>Segher Boessenkool writes:
>>>>>>
>>>>>>
>Segher> Well, the newest PowerPC architecture docs say that it is
>Segher> an optional insn, i.e., not all cpus might implement it.
>
>Segher> I can't say whether the 970 implements it or not.
>
>	mcrxr is obsolete and not implemented in PPC970.  Executing the
>instruction will result in an illegal instruction trap.
>
>David
>
>
>
Well this much is obvious. Where can I find a list
of these obsolete instructions so that I can
implement them in the illegal instruction handler?

The IBM documentation for the 970 declares these instructions
as the previous architecture papers, i.e. as nothing special.

Regards

Pantelis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
