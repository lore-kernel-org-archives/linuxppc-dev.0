Message-ID: <XFMail.981211124026.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.BSF.3.96.981209132155.3987A-100000@studenti.ing.unipi.it>
Date: Fri, 11 Dec 1998 12:40:26 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Giovanni Liotine <s156658@studenti.ing.unipi.it>
Subject: RE: Compiler porblems
Cc: Ralf Weidemann <RalfW@Scalar.de>, hagopiar@vuser.vu.union.edu,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 09-Dec-98 Giovanni Liotine wrote:
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

Try the latest EGCS-1.1.1 available at:
  ftp://ftp.linuxppc.org/pub/gary/redhat/RPMS/ppc
Pick up the 'egcs-*1.1-1b*' packages.  These are suitable for existing
Linux/PPC (pre GLIBC-2.1.xx) systems.

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
