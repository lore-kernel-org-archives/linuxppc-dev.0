To: Kim J?rgensen <KIJ@infocom.dk>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: X-server for the mpc823 LCD controller?
References: <819E3E914E0AD11194DE00805F0D100B0138B84B@fbi.infocom.dk>
From: Marcus Sundberg <marcus@cendio.se>
Date: 01 May 2000 21:28:23 +0200
In-Reply-To: Kim J?rgensen's message of "Mon, 1 May 2000 14:10:30 +0200"
Message-ID: <vepur69ijs.fsf@biffen.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim Jørgensen <KIJ@infocom.dk> writes:

> I would like to run X-windows (or something similar) on my custom mpc823
> board. So I'm looking for a X-server for the mpc823 LCD controller, is there
> any one out there?
>
>
> I have used the RPXL LCD frame buffer on my RPXL board, with the program
> dispbmp. Is the source code available for this program?
> Can any existing graphical server use this frame buffer?

XGGI (http://www.stacken.kth.se/~mackan/ggi/xggi/) should run fine on
the 823 together with my not-yet-released-but-as-soon-as-I-get-time-
to-commit-it LibGGI driver for the 823.

However I have not attempted to cross-compile XGGI yet, so someone
with a faster LinuxPPC box than an 8xx and some spare time is welcome
to try a native compile.

Unlike Microwindows XGGI is a real, full-featured, X-server. This
ofcourse means that it's larger than Microwindows, but it's still
smaller than common X-servers:
XF86_SVGA       - 2.6 MB
XF86_FBDev      - 1.9 MB
XGGI            - 1.5 MB

//Marcus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
