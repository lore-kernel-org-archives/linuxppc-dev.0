To: Dmitriy.Zavin@infineon.com
Cc: Chuck_Partridge@amx.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC2 and SCC3 serial ports on RPX Classic (MPC860) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Mar 2003 14:38:40 PST."
             <FD90897E35ABD311AE0E0008C7E6404A07192EE0@ca02exch4.sjc.infineon.com>
Date: Thu, 27 Mar 2003 00:57:40 +0100
Message-Id: <20030326235745.437B0C58BA@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <FD90897E35ABD311AE0E0008C7E6404A07192EE0@ca02exch4.sjc.infineon.com> you wrote:
>
> I also took a look at the hex values that I actually receive and it does NOT look like the bit-string is offset by any bits. There's no direct mapping that I can see..

Well, can you post an example, i. e. which output  do  you  get  when
sending the string "01234567890123456789abcdefghabcdefgh" ?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I usually tell my classes "if you are using @ and [] together in this
class, you will almost certainly NOT get what you want. That's  going
down  the wrong tunnel. There's no cheese at the end of that tunnel."
         -- Randal L. Schwartz in <8czptuomey.fsf@gadget.cscaper.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
