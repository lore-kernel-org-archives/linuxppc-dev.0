To: "Rupesh S" <rupeshs@myw.ltindia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MC850 peripheral support in linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 25 Mar 2004 18:21:06 +0530."
             <s0632321.003@EMAIL>
Date: Thu, 25 Mar 2004 20:36:55 +0100
Message-Id: <20040325193700.42BCAC118A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <s0632321.003@EMAIL> you wrote:
>
> 1) Does the I2C bus support in the kernel works for the internal I2C controller of MC850
> 2) Does the RTC support in the kernel (char driver) works for the internal RTC of MC850
> 3) Does the PCMCIA support in the kernel (IDE drivers)  works for the internal PCMCIA Socket controller of MC850

3 x yes. But I can only speak of the DENX kernel trees.

> This is to help me finalizing Linux for one of my Embedded Projects that will be built on MC850.

Don't expect too much of performance out of a 850;  the  tiny  caches
are a major pain.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are three things I always forget. Names, faces -  the  third  I
can't remember.                                         - Italo Svevo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
