To: Erik Christiansen <erik@dd.nec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boot Loader 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Dec 2002 17:05:09 +1100."
             <20021209060509.GA5743@dd.nec.com.au>
Date: Mon, 09 Dec 2002 08:43:47 +0100
Message-Id: <20021209074352.78A33C6267@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021209060509.GA5743@dd.nec.com.au> you wrote:
>
>    Had a look at http://sourceforge.net/projects/u-boot , as recently
> mentioned by Jerry Van Baren, but the site states "This Project Has Not
> Released Any Files", and the cvs repository link states "Only project
> developers can access the CVS tree via this method."

It is correct that we haven't released an official version of  U-Boot
yet, but as you can see from the project page it is based on PPCBoot,
which has been around for _some_ time.

And of course the CVS repository  _is_  available  to  everybody  for
anonymous CVS access. The page you quote is pretty clear:

	Anonymous CVS Access

        This project's SourceForge.net CVS repository can be checked
        out through anonymous (pserver) CVS with the following
        instruction set. The module you wish to check out must be
        specified as the modulename. When prompted for a password for
        anonymous, simply press the Enter key.

	cvs -d:pserver:anonymous@cvs.u-boot.sourceforge.net:/cvsroot/u-boot login

	 cvs -z3 -d:pserver:anonymous@cvs.u-boot.sourceforge.net:/cvsroot/u-boot co modulename

         Updates from within the module's directory do not need the
	-d parameter.

Developer access is indeed for developers only.

>    Until the U-Boot surfaces, would this be a good way to go, when faced
> with a custom board?

No.  You  should  not  spend  time  on  a  project  which  has   been
discontinued. Just download the latest (top of tree) version from the
U-Boot CVS server.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Ernest asks Frank how long he has been working for the company.
        "Ever since they threatened to fire me."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
