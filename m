To: "Rupesh S" <rupeshs@myw.ltindia.com>
Subject: Re: DENX kernel support for MPC885 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 16 Apr 2004 02:33:47 +0530."
             <s07f4611.076@EMAIL>
Date: Fri, 16 Apr 2004 00:22:03 +0200
Message-ID: <1BEFFh-0k9jyi0@fmrl00.sul.t-online.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <s07f4611.076@EMAIL> you wrote:
>
> I was just planning to use MPC885 for my embedded sytem that will be running Linux as the platform Operating System.
> Can somebody help me know if Linux for PowerPC supports the MPC885 Processor.

The  standard  source  trees  like  linuxppc-2.4  etc.  contain  only
partioal support, i. e. as far as the MPC8xx support fits.

> I specifically checked out the hardware supported by the DENX kernel, in which I could not see MPC885.

This is correct. Our code base is 2.4.25, which does not yet  include
specific MPC885 support.

> Though the Core os MPC885 is 8xx, MPC8xx has got _two ethernet_ and a USB which can act as master and slave.
> Does the DENX linux support these drivers.

Not yet. Sames as in "official" linuxppc-2.4.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Madness takes its toll. Please have exact change.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
