Message-ID: <21A8AE56EBB6D411A4520060973D360101A9F95F@PEPINTERCOM>
From: Claus Gindhart <Claus.Gindhart@kontron.com>
To: "'Omanakuttan'" <omanakuttan@tataelxsi.co.in>,
	Graf Alex <alex.graf@siemens.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: AW: parse error before `{', stray '\' in program
Date: Thu, 10 Apr 2003 14:31:59 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yet another proposal:

Install a CVS-Server somewhere on a Linux machine.
When You check out Your sources to Windows, You have \r\n
When You check out Your sources to Linux, You have \n

So You can edit on every platform with the native end-of-line
format. And, anyway, it gives you a lot of advantages
in concurrent programming.

I am not a fan of the dos2unix, and unix2dos tools.
dos2unix is o.k., but unix2dos can also create files
with \r\r\n line feeds, if you use it unintentionally
twice on the same file. If you dont want CVS, i wuld
recommend UltraEdit for editing and DOS/UNIX and
vice versa conversion.


> -----Original Message-----
> From: Omanakuttan [mailto:omanakuttan@tataelxsi.co.in]
> Sent: Donnerstag, 10. April 2003 14:23
> To: Graf Alex
> Cc: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: Re: AW: parse error before `{', stray '\' in program
>
>
>
> > I would use Unix file formats if i can!
> > The problem is: We have developers on Windows. They are
> working with the
> > same library as we are. Visual Studio produce this f...
> <cr><lf> or ^M or
> > \r\n. And we are generatin code from Rose. This cause the
> same problems.
> > Visual Studio has no problems with \n, but if someone save
> the file with
> > Visual Studio, the problem occurs. (The same is with Rose)
> > gcc 3.2 on host has no problem with this <cr><lf>. Is there
> allready a cross
> > compiler (ppc_8xx-gcc) with verision 3.2? Or how difficult
> is it to build a
> > new compiler?
> Why don't you use dos2unix command ?
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
