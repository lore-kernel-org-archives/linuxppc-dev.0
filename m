Date: Tue, 23 Apr 2002 12:14:16 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin Kuster <akuster@mvista.com>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Status on 405GP i2c driver
Message-ID: <20020423121416.A19665@ecam.san.rr.com>
References: <20020422141601.B16319@ecam.san.rr.com> <3CC59FD9.1090606@mvista.com> <20020423111518.A19441@ecam.san.rr.com> <3CC5A96B.2060502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CC5A96B.2060502@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 23, 2002 at 11:35:23AM -0700, Armin Kuster wrote:
> andrew may wrote:
>
> > On Tue, Apr 23, 2002 at 10:54:33AM -0700, Armin Kuster wrote:
> >
> >>then I recommend using ppcboot.
> >>
> >
> > Have you worked on the driver much recently? If not I can
> > take a run at it and submit it, but I don't know how much
> > of the comment OCP driver stuff I will get done.
> >
> Andrew,
>
>
>
> I have done a lot of work on it and I submitted it to the i2c mailing
> list.  There is a bit more to do and i am in the middle of change the
> ocp stuff.

I take it this is it: http://archives.andrew.net.au/lm-sensors/msg00995.html.
The file renames hides the actual changes you have made. I still don't
see it in CVS yet.

Do you plan to continue to try to go to the i2c people or just stick in
the BK tree? If we both start working on it it would be much easier in
the BK tree.

I will be using the i2c bus for my RTC so I have no real intrest in building
things outside the main kernel.

When you say change "ocp stuff" is that just for the i2c driver or all of
the ocp drivers?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
