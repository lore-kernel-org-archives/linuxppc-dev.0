Message-ID: <9CFB9DA5261CD611A29B00508B78904807F88115@ex-deu-munich02.force.de>
From: "Demke, Torsten" <Torsten.Demke@fci.com>
To: Wolfgang Denk <wd@denx.de>,
	"Demke, Torsten" <Torsten.Demke@fci.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: problem with standard libc on 8xx 
Date: Fri, 27 Feb 2004 11:11:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Wolfgang,

so what is your proposal, to solve the problem?
I would like to use Debian binaries, but I cannot
use the floating point emulation of the kernel!?

Regards,
Torsten


> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Freitag, 27. Februar 2004 10:43
> To: Demke, Torsten
> Cc: Linuxppc-Embedded (E-mail)
> Subject: Re: problem with standard libc on 8xx
>
>
> In message
> <9CFB9DA5261CD611A29B00508B78904807F880ED@ex-deu-munich02.forc
> e.de> you wrote:
> >
> > I created my own root-fs for a MPC8xx platform
> > using standard Debian packages (including libc).
> > When I start the system, the init scripts hangs
> ...
> > I guess that the Debian libc uses floating point - which
>
> Thi sis definitely one cause of the problem.  Another  one  might  be
> optimization  for  a  incorrect  cache  line  size  (32 instead of 16
> bytes).
>
> > is not available on MPC8xx - but I thougt the kernel would
> > emulate this calls (CONFIG_MATH_EMULATION=y).
>
> This has never been working reliably for any real-life code. And it's
> awfully slow.
>
> Also note that you CANNOT mix standard binaries (from Debian) and 8xx
> specific libraries (from ELDK) -  this  will  crash  as  soon  as  an
> application attempts to use floating point.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Above all else -- sky.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
