Message-ID: <XFMail.000524185952.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <8xitw3ewcc.fsf@s63.informatik.uni-bremen.de>
Date: Wed, 24 May 2000 18:59:52 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_ALTIVEC=y
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Nicholas Coult <coult@ima.umn.edu> writes:
>
>>
>> When a kernel is compiled with CONFIG_ALTIVEC=y, I assume this
>> means that the kernel is aware of the Altivec registers, and keeps
>> track of their contents during context switches?  And that code
>> which uses Altivec instructions/registers will run properly with such
>> a kernel?
>>
> Yes.
>
>   Holger

Does it take care of VRSAVE or it saves all VRs every context switch ?

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
