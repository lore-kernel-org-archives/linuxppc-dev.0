Date: Wed, 22 Sep 1999 09:39:45 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@cpu.lu>
cc: pogtal@erols.com, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: ssh2 and multiheaded X
In-Reply-To: <199909220616.IAA00379@piglet.cpu.lu>
Message-ID: <Pine.HPX.4.10.9909220935310.7776-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 22 Sep 1999, Michel Lanners wrote:

> 
> On  21 Sep, this message from Doomsday Machine echoed through cyberspace:
> > 
> > Greetings all-
> >     Has anyone successfully compiled ssh2 or gotten some version of
> > multiheaded X working?  ssh1 is pretty useless, since any machine not
> > running linuxppc is running ssh2, not ssh1.
> 
> I tried compiling ssh2, but it aborts with errors on va_arg. Something
> with assigment of incompatible types...

There have been many problems with va_args on PPC due to the fact that the
designers of the SYSV varargs interface had to stand out :-( 

 Basically you have to use the provided standard macros and _never_ try to
outsmart them because `everybody knows that actually you can simply walk
an array' is utterly wrong on PPC. 

And I don't enter the alignment issues which have changed between
versions...

Disclaimer: I've not seen the code, but there have been several varargs
related problems and this was always the answer AFAIR. 

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
