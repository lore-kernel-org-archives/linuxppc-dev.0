Subject: Re: Gcc longcall option
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Diaconescu Bogdan-BDIACON1 <bogdan.diaconescu@motorola.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <DD38D67B9196D31189EC00508B62563701C4921F@zro01exm01.corp.mot.com>
References: 
	 <DD38D67B9196D31189EC00508B62563701C4921F@zro01exm01.corp.mot.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1059043329.14946.198.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 24 Jul 2003 12:42:10 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-07-22 at 17:34, Diaconescu Bogdan-BDIACON1 wrote:
>
> I have a question not strictly related to kernel but more related to
> gcc and it's options.
>
> I try to create a big exe image (around 800M with symbolics) using
> gcc-2.95.x and I run into the problems of relative branch addressing
> which has only 24 bits for PPC. I know if I use some __atribute__
> ((longcall)) for function prototypes the addressing is done through LR
> so it's changed to indirect branch. I was looking for options like
> -mlongcall or -mlong-calls but it seems they don't exist for PPC.
>
> Now the question: do you know a distribution in which gcc is having
> such options or do you know another way to get the link done with the
> big exe image I have?

I'm not a gcc expert, but have you tried -fPIC and friends?


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
