To: Jeff Stevens <JStevens@SYSTRAN.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK based on YDL 3.0? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 13 Nov 2003 10:04:02 EST."
             <D13FBFDEA70AD111A44900A0C92316930350B757@postoffice.systran.com>
Date: Thu, 13 Nov 2003 17:46:33 +0100
Message-Id: <20031113164638.3336BC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <D13FBFDEA70AD111A44900A0C92316930350B757@postoffice.systran.com> you wrote:
>
> 	I am currentlly using ELDK v2.1.0 and am wanting to update to kernel
> 2.4.22.  I need to update to 2.4.22 for an openIPMI patch that I have.  I

That should be no problem. Except  for  a  few  rare  situations  the
kernel  is  completely  independend  of  the  tool chain and userland
applications.

> tried compiling the PPC 2.4.22 kernel, but it complains about the libarg.h
> file missing.  I think this is becuase the version of ppc_8xx-gcc in ELDK
> v2.1.0 is too old for the kernel rev 2.4.22.  Is that correct?  I'd rather

No, this is not  correct.  We're  using  the  "old"  (2.1)  ELDK  for
production all the time, including latest kernel versions.

> just wait, if you are close to releasing a new version of ELDK.

Don't wait. The problem might not be in the ELDK but somwhere else.


libarg.h? Never heard of that. Which file attempts to include this?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You cannot propel yourself forward by patting yourself on the back.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
