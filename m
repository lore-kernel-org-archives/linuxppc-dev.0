To: Ibon Gotxi Garcia <igotxi@jazzfree.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>,
	Dan Malek <dan@embeddededge.com>,
	Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about modules 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "04 Mar 2003 13:03:30 GMT."
             <1046783010.328.73.camel@muse>
Date: Tue, 04 Mar 2003 15:15:27 +0100
Message-Id: <20030304141532.E7AABC6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1046783010.328.73.camel@muse> you wrote:
>
> I understand that reason, and i'm not certain about the usefulness of
> modules in embedded systems.

They are _very_ useful during development. They may also be useful to
make  driver  initialization   and/or   operation   controllable   by
application code.

In general you are right: statically linking the required drivers  is
usually a better approach.

> Anyway, my original purpose was to develop the driver as a module, and
> afterwards insert it into the kernel. I have just done it adding the
> EXPORT_SYMBOL macro to commproc.c and listing it in export-objs in
> arch/ppc/8xx_io/Makefile. Right, isn't it?

Yes, this is all that is needed.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"In the face of entropy and nothingness, you kind of have to  pretend
it's  not  there  if  you  want  to  keep writing good code."
- Karl Lehenbauer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
