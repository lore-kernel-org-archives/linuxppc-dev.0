Message-Id: <5.2.1.1.2.20030724130854.01be5458@mail.lauterbach.com>
Date: Thu, 24 Jul 2003 13:11:26 +0200
To: Diaconescu Bogdan-BDIACON1 <bogdan.diaconescu@motorola.com>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: Gcc longcall option
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <DD38D67B9196D31189EC00508B62563701C4921F@zro01exm01.corp.m
 ot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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
