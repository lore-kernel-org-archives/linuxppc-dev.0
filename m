Message-Id: <4.2.1.10.19991013114246.00d1d1b0@mail.lauterbach.com>
Date: Wed, 13 Oct 1999 11:48:37 +0200
To: michael.fenske@arcormail.de
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Problem with glibc-2.1.3-0a.src.rpm ?
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3804499E.291265F@arcormail.de>
References: <3803A7BC.4175E431@arcormail.de>
 <99101300580600.00880@ns1102.munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:58 13.10.99 , Michael Fenske wrote:
>Franz Sirl wrote:
> >
> > Did you install all parts of gcc-2.95.1? cpp is easily forgotten. What 
> output
> > do you get from 'egcs -v' and 'gcc -v'?
>
>I have installed the following parts:
>
>   cpp-2.95.1-0a
>   gcc-2.95.1-0a
>   gcc-c++-2.95.1-0a
>   gcc-objc-2.95.1-0a
>
>egcs -v returns
>
>   bash: egcs: command not found  // what a surprise ;-)
>
>gcc -v returns
>
>   Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/specs
>   gcc version 2.95.1 19990809 (prerelease)

Which rpm version are you using? In any case, try upgrading to 3.0.3 
<ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/ppc/> and then reinstall 
gcc-2.95.1.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
