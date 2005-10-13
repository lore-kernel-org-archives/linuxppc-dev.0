Return-Path: <davidkwho@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.207])
	by ozlabs.org (Postfix) with ESMTP id A855F68550
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 00:32:11 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id c12so123697qbc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 07:32:10 -0700 (PDT)
Message-ID: <4dd15d180510130725o3c23326i6f9703015401a381@mail.gmail.com>
Date: Thu, 13 Oct 2005 10:25:15 -0400
From: David Ho <davidkwho@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <4dd15d180510130720m45089eafk10cd9936457ced8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5065_18851790.1129213515763"
References: <4dd15d180510130720m45089eafk10cd9936457ced8b@mail.gmail.com>
Subject: Re: NPTL support on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5065_18851790.1129213515763
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

glibc used on ELDK 3.0 is still using linuxthreads.

David

bash-2.05# ./libc.so.6
GNU C Library stable release version 2.3.1, by Roland McGrath et al.
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)=
.
Compiled on a Linux 2.4.24-pre2 system on 2004-02-17.
Available extensions:
GNU libio by Per Bothner
crypt add-on version 2.1 by Michael Glad and others
linuxthreads-0.10 by Xavier Leroy
BIND-8.2.3-T5B
libthread_db work sponsored by Alpha Processor Inc
NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
software FPU emulation by Richard Henderson, Jakub Jelinek and others
Report bugs using the `glibcbug' script to <bugs@gnu.org>.


On 10/13/05, David Ho <davidkwho@gmail.com> wrote:
>
> Hi all,
>
> Just out of curiosity, is NPTL support already available on PPC?
>
> I believe there are 2 parts to it. Kernel support which is probably
> already there in 2.6. And the other is glibc, is there a generally
> available toolchain (i.e. ELDK) that already support NPTL?
>
> Thanks, David
>

------=_Part_5065_18851790.1129213515763
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

glibc used on ELDK 3.0 is still using linuxthreads.<br>
<br>
David<br>
<br>
bash-2.05# ./libc.so.6<br>
GNU C Library stable release version 2.3.1, by Roland McGrath et al.<br>
Copyright (C) 2003 Free Software Foundation, Inc.<br>
This is free software; see the source for copying conditions.<br>
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A<br>
PARTICULAR PURPOSE.<br>
Compiled by GNU CC version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)=
.<br>
Compiled on a Linux 2.4.24-pre2 system on 2004-02-17.<br>
Available extensions:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GNU libio by Per Bothner<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crypt add-on version 2.1 by Mich=
ael Glad and others<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linuxthreads-0.10 by Xavier Lero=
y<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIND-8.2.3-T5B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libthread_db work sponsored by A=
lpha Processor Inc<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NIS(YP)/NIS+ NSS modules 0.19 by=
 Thorsten Kukuk<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; software FPU emulation by Richar=
d Henderson, Jakub Jelinek and others<br>
Report bugs using the `glibcbug' script to &lt;<a href=3D"mailto:bugs@gnu.o=
rg">bugs@gnu.org</a>&gt;.<br>
<br><br><div><span class=3D"gmail_quote">On 10/13/05, <b class=3D"gmail_sen=
dername">David Ho</b> &lt;<a href=3D"mailto:davidkwho@gmail.com">davidkwho@=
gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
Hi all,<br>
<br>
Just out of curiosity, is NPTL support already available on PPC?<br>
<br>
I believe there are 2 parts to it.&nbsp; Kernel support which is
probably already there in 2.6.&nbsp; And the other is glibc, is there a
generally available toolchain (i.e. ELDK) that already support NPTL?<br>
<br>
Thanks, David<br>

</blockquote></div><br>

------=_Part_5065_18851790.1129213515763--
