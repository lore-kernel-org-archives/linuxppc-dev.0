To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Binary Compatibility of various flavors of PPC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Oct 2002 13:17:37 CDT."
             <Pine.LNX.4.33.0210141315200.24959-100000@localhost.localdomain>
Date: Mon, 14 Oct 2002 20:22:12 +0200
Message-Id: <20021014182217.658DCFAA5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.33.0210141315200.24959-100000@localhost.localdomain> you wrote:
>
> > > One of our requirements is to be able to run the same binary image across
> > > a range of systems. The image can not change just because the processor
> > > does.
> > >
> > > We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC III.
> >
> > What do you mean with "image"?
> >
> > Kernel Image? Application image (for example ramdisk  with  libraries
> > and application binaries)? Both combined?
>
> Both combined. A bzImage and RAM disk loaded off the boot media (Flash).

That makes for an easy answer: no go.

4xx and 82xx are different enough the required efford  to  just  make
one  kernel  image  run on all these CPU makes no sense; neither from
the technical nor from the economical point of  view.  And  user-land
stuff (libraries, applications) is yet another story.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"More software projects have gone awry for lack of calendar time than
for all other causes combined."
- Fred Brooks, Jr., _The Mythical Man Month_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
