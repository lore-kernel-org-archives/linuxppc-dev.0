Message-ID: <DD38D67B9196D31189EC00508B62563701CA64B5@zro01exm01.corp.mot.com>
From: Diaconescu Bogdan-BDIACON1 <bogdan.diaconescu@motorola.com>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: Gcc longcall option
Date: Fri, 25 Jul 2003 19:14:48 +0300
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks,
I'll try gcc-3.3 version whith the pragm you said.

Bogdan

-----Original Message-----
From: Franz Sirl [mailto:Franz.Sirl-ppc@lauterbach.com]
Sent: Thursday, July 24, 2003 2:11 PM
To: Diaconescu Bogdan-BDIACON1
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Gcc longcall option


At 17:34 22.07.2003, Diaconescu Bogdan-BDIACON1 wrote:

>Hi guys,
>
>I have a question not strictly related to kernel but more related to
>gcc and it's options.
>
>I try to create a big exe image (around 800M with symbolics) using
>gcc-2.95.x and I run into the problems of relative branch addressing
>which has only 24 bits for PPC. I know if I use some __atribute__
>((longcall)) for function prototypes the addressing is done through LR
>so it's changed to indirect branch. I was looking for options like
>-mlongcall or -mlong-calls but it seems they don't exist for PPC.
>
>Now the question: do you know a distribution in which gcc is having
>such options or do you know another way to get the link done with the
>big exe image I have?

Starting with gcc-3.3 there is "#pragma longcall (1)", so depending on
where you put this pragma, you can default your project/module/file to
longcalls.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
