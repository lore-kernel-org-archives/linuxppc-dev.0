In-Reply-To: <406C1E50.1010806@intracom.gr>
References: <406C1E50.1010806@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v613)
Message-Id: <EC443756-84BA-11D8-89ED-000A95A4DC02@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [OT?] Unimplemented instructions on a G5?
Date: Fri, 2 Apr 2004 17:32:17 +0200
To: Pantelis Antoniou <panto@intracom.gr>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The offending instruction is the seemingly harmless:
>
>  mcrxr crX
>
>   (Move to condition register from XER).
>
> Does anyone have any idea if IBM left this instruction
> unimplemented. Searching the docs I've found nothing.

Well, the newest PowerPC architecture docs say that it is
an optional insn, i.e., not all cpus might implement it.

I can't say whether the 970 implements it or not.

http://www-106.ibm.com/developerworks/eserver/pdfs/archpub1.pdf
Chapter 6.

> If it is unimplemented any idea of how hard it will be to
> trap and emulate it?

In Linux?

Last time I did this, it was easy.  Can't seem to find the
patch right now, though.

Emulating will be slow, of course (but I think you know that).


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
