From: Graf Alex <alex.graf@siemens.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <791B3205DB661A42B4BFE5464A7D1D02010E44F4@chzugexch02.zug.ch.abatos.com>
Subject: AW: parse error before `{', stray '\' in program 
Date: Thu, 10 Apr 2003 13:15:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would use Unix file formats if i can!
The problem is: We have developers on Windows. They are working with the
same library as we are. Visual Studio produce this f... <cr><lf> or ^M or
\r\n. And we are generatin code from Rose. This cause the same problems.
Visual Studio has no problems with \n, but if someone save the file with
Visual Studio, the problem occurs. (The same is with Rose)
gcc 3.2 on host has no problem with this <cr><lf>. Is there allready a cross
compiler (ppc_8xx-gcc) with verision 3.2? Or how difficult is it to build a
new compiler?

Cheers

Alex Graf


...
This is usually caused by illegal file formats.

> The troubles are coming from the dos <cr><lf> at line end. With gcc 3.2
> (from host) I don't have this problems.

Use Unix file formats (plain '\n' line termination).
Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
