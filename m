Message-Id: <200404021549.i32FnZT35302@makai.watson.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>,
	Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [OT?] Unimplemented instructions on a G5? 
In-Reply-To: Message from Segher Boessenkool <segher@kernel.crashing.org>
   of "Fri, 02 Apr 2004 17:32:17 +0200." <EC443756-84BA-11D8-89ED-000A95A4DC02@kernel.crashing.org>
References: <406C1E50.1010806@intracom.gr>  <EC443756-84BA-11D8-89ED-000A95A4DC02@kernel.crashing.org> 
Date: Fri, 02 Apr 2004 10:49:35 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> The offending instruction is the seemingly harmless:
>>
>> mcrxr crX
>>
>> (Move to condition register from XER).
>>
>> Does anyone have any idea if IBM left this instruction
>> unimplemented. Searching the docs I've found nothing.

>>>>> Segher Boessenkool writes:
Segher> Well, the newest PowerPC architecture docs say that it is
Segher> an optional insn, i.e., not all cpus might implement it.

Segher> I can't say whether the 970 implements it or not.

	mcrxr is obsolete and not implemented in PPC970.  Executing the
instruction will result in an illegal instruction trap.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
