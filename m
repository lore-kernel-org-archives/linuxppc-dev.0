Message-ID: <387BEF87.25EC6A2A@charter.net>
Date: Tue, 11 Jan 2000 21:05:43 -0600
From: Dan Dickey <ddickey@charter.net>
MIME-Version: 1.0
To: Grant Erickson <grant@borg.umn.edu>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: My cookbook approach to building a cross compiler for the powerpc on
 an intel x86 Linux box
References: <200001100522.XAA07318@congo.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grant Erickson wrote:
> 
> Also, consider the documentation at:
> 
>      http://www.lcse.umn.edu/~grant/Linux/cross.html
> 
> Regards,
> 
> Grant Erickson

Grant,
thanks for the pointer!
This is fantastic!  I believe that it would have saved me at least
an hour last Saturday had I known about your page.  Ah well.

It looks like your page is a good reference for building
a "straight" cross-compiler environment.  Building applications
based on glibc that will actually run on the target machine with
Linux as the OS.
What I was trying to do to begin with was a bit simpler - just
build a cross environment to allow code to run on one of the
PPC boards that are available.  No OS yet, certainly not glibc.

What I imagined is having one environment for building the
"simple" environment, and a later one for actually building
the applications to run on Linux with glibc.
	-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
