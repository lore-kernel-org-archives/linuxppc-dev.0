From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199909221109.NAA30216@amber.biophys.uni-duesseldorf.de>
Subject: Re: ssh2 and multiheaded X
In-Reply-To: <Pine.HPX.4.10.9909220935310.7776-100000@gra-ux1.iram.es> from Gabriel Paubert at "Sep 22, 1999 09:39:45 am"
To: paubert@iram.es (Gabriel Paubert)
Date: Wed, 22 Sep 1999 13:09:12 +0200 (CEST)
Cc: mlan@cpu.lu, pogtal@erols.com, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I tried compiling ssh2, but it aborts with errors on va_arg. Something
> > with assigment of incompatible types...
> 
> There have been many problems with va_args on PPC due to the fact that the
> designers of the SYSV varargs interface had to stand out :-( 
> 
>  Basically you have to use the provided standard macros and _never_ try to
> outsmart them because `everybody knows that actually you can simply walk
> an array' is utterly wrong on PPC. 
> 
> And I don't enter the alignment issues which have changed between
> versions...
> 
> Disclaimer: I've not seen the code, but there have been several varargs
> related problems and this was always the answer AFAIR. 

I still get segfaults due to varargs even though I use the standard macros. 
That's with gcc 2.95.1 and it seems to involve pointers to user defined
structs solely. Haven't had time to debug this lately but I can try to write
some sample code to demonstrate it. 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
