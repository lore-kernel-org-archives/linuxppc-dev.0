Message-Id: <200208081345.PAA08157@hzsms01.nl.lucent.com>
Date: Thu, 8 Aug 2002 15:45:34 +0200 (MEST)
From: Jaap-Jan Boor <jjboor@lucent.com>
Reply-To: Jaap-Jan Boor <jjboor@lucent.com>
Subject: Re: occasionally segmentation faults 
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolgang,

I upgraded to gcc2.95.3 and glibc-2.2.5, same problem.

then I downloaded and installed you eldk, but still
have sometimes the segmentation fault.

My kernel is under suspicion now. I saw eldk also
contains a 2.4.4 kernel (I use 2.4.10)

Did you apply something else then the uart changes to it?

thanks,

Jaap-Jan


> > I've some problems with my built cross environment
> > from sparc-solaris to powerpc 8xx.
> >
> > I configured and built gcc2.95.2 and glibc-2.1.3
> > and used that to build the file and sh utils etc.
>
> These versions are pretty old.
>
> Why don't you use our ELDK,  which  is  available  for  Solaris  host
> environment, too? It's working fine...
>
> See http://www.denx.de/ELDK/
>
> Wolfgang Denk
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
