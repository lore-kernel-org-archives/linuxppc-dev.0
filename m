Message-ID: <3DFF2956.6020903@intracom.gr>
Date: Tue, 17 Dec 2002 15:40:38 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kmalloc and startup process
References: <IGEFJKJNHJDCBKALBJLLKEODFIAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKEODFIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>Don't know when it's safe to call kmalloc, but maybe you
>should avoid kmalloc?  Is it possible to use
>kmalloc when the microcode(8xx_io/micropatch.c) is loaded?
>
>   Jocke
>
I fixed the problem via another way.

At startup I use a statically allocated area, or
the bootmem allocated page.

The kmalloc is used only when a request for memory
cannot be satisfied by this memory.

I will probably post the patch for the hostmem today,
followed tommorow by the patch for the dpmem.

Stay tuned.

>>
>>Hi
>>
>>I'm hacking now the 8xx hostalloc and dpalloc stuff,
>>and I have a a question.
>>
>>At what point in the startup process is it OK to call
>>kmalloc?
>>
>>I don't think it is safe at the setup_arch point.
>>
>>Is this correct?
>>
>>Thanks
>>
>>--
>>Pantelis Antoniou
>>INTRACOM S.A. Greece
>>
>>
>>
>>
>>
>
>


--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
