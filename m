To: Graf Alex <alex.graf@siemens.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: parse error before `{', stray '\' in program 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Apr 2003 11:23:49 +0200."
             <791B3205DB661A42B4BFE5464A7D1D02010E44F3@chzugexch02.zug.ch.abatos.com>
Date: Thu, 10 Apr 2003 11:48:26 +0200
Message-Id: <20030410094831.A1254C5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <791B3205DB661A42B4BFE5464A7D1D02010E44F3@chzugexch02.zug.ch.abatos.com> you wrote:
>
> If I have some defines which have '\' inside ...
>
> #define BIND_DESC_ALM \
> { \
> 	CAlmSourceProp::IdxBindingGrp; \
> }
>
> my cross compiler produce following output:
>
> ppc_8xx-gcc -fPIC -DPIC -D_DEBUG -Wall -ansi -g3 -O0
> -I/home/projects/Nscu/_Inc -I/home/projects/Nscu/_Inc_PC -c -o main.o
> main.cpp
> main.cpp:15: parse error before `{'
> main.cpp:15: stray '\' in program
> main.cpp:16: stray '\' in program

This is usually caused by illegal file formats.

> The troubles are coming from the dos <cr><lf> at line end. With gcc 3.2
> (from host) I don't have this problems.

Use Unix file formats (plain '\n' line termination).



Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Brain off-line, please wait.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
