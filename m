From: hagopiar@vuser.vu.union.edu
Date: Fri, 11 Dec 1998 19:54:55 -0500 (EST)
To: Giovanni Liotine <s156658@studenti.ing.unipi.it>
cc: linuxppc-dev@lists.linuxppc.org, hagopiar@vuser.vu.union.edu,
        Ralf Weidemann <RalfW@Scalar.de>
Subject: Re: Compiler porblems
In-Reply-To: <Pine.BSF.3.96.981209132155.3987A-100000@studenti.ing.unipi.it>
Message-ID: <Pine.LNX.4.05.9812111954150.12492-100000@sequoia.hagopian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Works fine for me with egcs 1.1.1 and glibc-2.1.104 (linuxppc-pre5 or
such). That is, after I changed that from "main" to "main ()" :-)
								-Rob H.

On Wed, 9 Dec 1998, Giovanni Liotine wrote:

> Date: Wed, 9 Dec 1998 13:36:33 +0100 (CET)
> From: Giovanni Liotine <s156658@studenti.ing.unipi.it>
> To: linuxppc-dev@lists.linuxppc.org
> Cc: hagopiar@vuser.vu.union.edu, Ralf Weidemann <RalfW@Scalar.de>,
     linuxppc-dev@lists.linuxppc.org
> Subject: Compiler porblems
> 
> Hi all
> I've some problem compiling c++ apps under linuxppc with egcs.1.0.2
> prerelease:
> during compiling this code 
> "#include <iostream.h>
>  main
>     {
>     } "
> 
> gcc output are a long series of warnings: invalid type 'void *' for
> default argument to 'ostream *'
> 
> When compiling some applications (that compile fine with gcc 2.8.1 under
> Intel/Linux) like MidsEye gcc results in internal compiler error, e.g:
> 
> In method 'void MatrixImage <float>::drawLine(int, int, int, int, float)
> Internal compiler error.
> 
> Is it a compiler bug or what?
> Any suggestion? Note that this code compile under Intel/Linux box.
> 
> Thanks
> Gianni. 
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
