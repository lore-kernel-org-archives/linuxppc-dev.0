From: tom_gall@vnet.ibm.com
Message-ID: <397DA4CE.D79D06AA@vnet.ibm.com>
Date: Tue, 25 Jul 2000 14:31:42 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: diff to tonight's kaffe cvs tree to work on ppc
References: <200007250345.VAA22028@faith.cs.utah.edu> <397D926F.111AF60E@ivey.uwo.ca> <397D9744.31E6BDC6@vnet.ibm.com> <397D9E3B.51E31B0E@ivey.uwo.ca>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:
>
> Hi Tom,
>
> Good to hear from you again!

Hi Kevin!

  Good to see you too!

> >   This is only true as far as the 64 bit systems running on the 32 bit kernel,
> > which is all there is at the moment.
>
> I am confused.  Which of the following is true on a 64 bit system running on a
> 32 bit kernel?
>
> A).  sizeof(unsigned int) > sizeof(void *)
>
> or
>
> B). sizeof(unsigned int) < sizeof(void *)

B is true. On the 64 bit kernel int is 32, long is 64, void * is 64.

> If A) is true, then my stack alignment macro will still work.  If B) is true, I
> am in trouble.

I wouldn't say you are in trouble. We're going to try to put in 32 bit binary
compatibility so current 32 bit apps should run on the 64 bit kernel without a
recompile. I think there's only potential trouble for someone who would
recompile Kaffe for the 64 bit kernel... but that doesn't exactly quite exist
yet...

> >   Work has started on the 64 bit PowerPC Linux kernel, if Kaffe is compiled as a
> > 64 bit app for that kernel then sizeof(unsigned long) = sizeof(void *) will be
> > true. Certainly not a big deal at this stage, but thought you'd be interested
> > none the less.
>
> Sounds good!  When IBM is ready to start giving 64bit systems to help
> developers, let me know! ;-)

Actually this sort of thing is starting to happen. While I can't promise
machines, it is possible to get a few out there here and there....

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
