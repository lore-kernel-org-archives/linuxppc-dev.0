Message-Id: <4.2.0.58.19990910201708.00c47c30@mail.lauterbach.com>
Date: Fri, 10 Sep 1999 20:19:56 +0200
To: Maurice DIAMANTINI <diam@pmdiam.ensta.fr>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: bug glibc strlen() or tcl8.2
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990910163126.A19797@pmdiam.ensta.fr>
References: <4.2.0.58.19990909192900.00af6450@mail.lauterbach.com>
 <19990909164200.A17615@pmdiam.ensta.fr>
 <4.2.0.58.19990909192900.00af6450@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 16:31 10.09.99 , Maurice DIAMANTINI wrote:

>     Vous disiez:
>     >
>     > >I'm unable to execute tcl8.2 on linuxppc R5. Although it compile and
>     > >and run very simply on intel box, solaris, ... but not on linuxppc
>     > > ...
>     > >The programm compils OK, but get a core dump at the first execution
>     > >of a tcl command (in fact at the "make test")
>     > ...
>     > >     memcpy ((VOID *) &tmpArgList, (VOID *) &argList, sizeof \
>     >                                                (tmpArgList));
>     >       ^^^^^^^^
>     > This is unportable in combination with va_list. Try:
>     >        __va_copy (tmpArgList, argList);
>
>     Danke Franz,
>
>     But when I modify the code (from the true tcl distrib):
>     (I do'nt thes function which aren't part of the tcl distrib.
>
>             // string = va_arg(tmpArgList, char *);
>             string = __va_arg(tmpArgList, argList);

??? I didn't tell you to do that. I meant: Replace the "memcpy" line in the 
source with the "__va_copy" line I sent you.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
