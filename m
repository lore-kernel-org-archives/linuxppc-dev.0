To: "Michael Meriin" <Michael@KSWaves.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SPI Driver for 8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Sep 2002 10:58:20 +0200."
             <059501c25971$606eb600$450fa8c0@amitesting>
Date: Wed, 11 Sep 2002 10:28:49 +0200
Message-Id: <20020911082854.400C2FA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Michael,

in message <059501c25971$606eb600$450fa8c0@amitesting> you wrote:
>
> Thank you very much for your quick response.
> But I failed to get to : http://www.denx.de/re/linux.html :((

Which sort of error message do you get?

Alternate way: go to http://www.denx.de , and click on "Software"

> I will be happy to get both drivers, because I have to control several SPI
> devices
> and therefore the driver must be complicated ;))

No, the driver stays as simple as is. You just have to add  separated
devices  based  on  how  your  hardware  implements the device select
function.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The two most common things in the universe are hydrogen  and  stupi-
dity."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
