Message-ID: <20030711204434.77298.qmail@web40307.mail.yahoo.com>
Date: Fri, 11 Jul 2003 13:44:34 -0700 (PDT)
From: Miku Jha <jha_miku@yahoo.com>
Subject: Re: cross compiling gdb for ppc 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030711070251.DEC2EC6D82@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
The solution worked.

I had to change the variable in solib.c file.

Thanks a ton


--- Wolfgang Denk <wd@denx.de> wrote:
> In message
> <20030711045749.4201.qmail@web40306.mail.yahoo.com>
> you wrote:
> >
> > When I run the gdb to debug the core file it
> somehow
> > refers to the libraries in the /lib path
> > the libraries for my target machine are somewhere
> > else.
> >
> > I wanted to know if there is any option or
> workaround
> > to make gdb point to correct libraries.
>
> RTFM.
>
> See especially the "solib-absolute-prefix" variable.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime
> Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88
> Email: wd@denx.de
> What the gods would destroy they first submit to  an
>  IEEE  standards
> committee.


=====
mailto:jha_miku@yahoo.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
