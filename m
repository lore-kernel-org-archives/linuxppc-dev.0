Date: Mon, 20 Mar 2000 17:54:41 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Rhys <rhiannon@miranda.inetsolve.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: limited range of data error
In-Reply-To: <200003202228.RAA22962@miranda.inetsolve.com>
Message-ID: <Pine.LNX.3.96.1000320175258.19093G-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 20 Mar 100, Rhys wrote:

> When i try to compile i get these errors:

> act_comm.c:2234: warning: comparison is always true due to
> limited range of data type

>    char BUFF[MAX_STRING_LENGTH];
>
>    if ((rpfile = fopen(ASCTITTLE_FILE, "r")) !=NULL) {
>      while (( BUFF[num]=fgetc(rpfile)) != OEF) // Line 2234

I assume that's EOF, and not OEF.  Anyway, this can be fixed by making
BUFF[] be an array of signed char instead of just char.  Ran into the same
issue this past wekend in some code I was writing.


Later,
David

---------------------------------------------------------------------
A logician trying to explain logic to a programmer is like a cat
trying to explain to a fish what it's like to be wet.

	-- unknown, possibly Franklin Veaux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
