To: "Brian S. Park" <brian@corelis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: getting Linux working on IBM Walnut demo board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 May 2003 13:17:06 PDT."
             <5.1.1.6.2.20030529131257.01276478@corelis.com>
Date: Thu, 29 May 2003 22:26:13 +0200
Message-Id: <20030529202618.BD122C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.1.6.2.20030529131257.01276478@corelis.com> you wrote:
>
> I need more help!
> Some time, when u-Boot is trying to download the linux kernel image over

I recommend to send such messages to the u-boot-users  mailing  list.
They are off topic here.

> Also, I was wondering if it's possible to make u-boot image that will work
> with 256KB of ram/flash.

You mean your board has just 256 kB RAM? Really??

Well, the U-Boot image can be made to fit easily in 128 kB  or  less;
you  will have to configure for a smaller malloc area. The U-Boot can
probably run in 256 kB RAM - but what for?  There  will  not  be  any
memory left for U-Boot's main purpose: to load an OS.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Obviously, a major malfunction has occurred."
              -- Steve Nesbitt, voice of Mission Control, January 28,
                 1986, as the shuttle Challenger exploded within view
                 of the grandstands.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
