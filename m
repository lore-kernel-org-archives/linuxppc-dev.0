Date: Tue, 21 Mar 2000 03:22:25 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: Rhys <rhiannon@miranda.inetsolve.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: limited range of data error
In-Reply-To: <Pine.LNX.3.96.1000320175258.19093G-100000@deepspace.mklinux.org>
Message-ID: <Pine.HPX.4.10.10003210316050.28648-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 20 Mar 2000, David A. Gatwood wrote:

> >    if ((rpfile = fopen(ASCTITTLE_FILE, "r")) !=NULL) {
> >      while (( BUFF[num]=fgetc(rpfile)) != OEF) // Line 2234
>
> I assume that's EOF, and not OEF.  Anyway, this can be fixed by making
> BUFF[] be an array of signed char instead of just char.  Ran into the same
> issue this past wekend in some code I was writing.

This is the quick, dirty and _wrong_ fix since it does not distinguish
EOF from '\0xff'. See my other post, and sorry for being harsh, but I'm
extremely upset about this and all the code compiled with -fsigned-char
whose most important effect is to hide precisely this bug, by curing the
symptom and not the cause.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
