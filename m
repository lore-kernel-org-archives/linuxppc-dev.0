To: "Yang, Bo" <bo.yang@transcore.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Debugging 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Apr 2003 15:38:32 MDT."
             <406B9D084FAFD4118C980008C79FADB901B57FF7@ALBMAIL>
Date: Tue, 15 Apr 2003 01:18:02 +0200
Message-Id: <20030414231807.C06C7C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <406B9D084FAFD4118C980008C79FADB901B57FF7@ALBMAIL> you wrote:
>
> I got a bunch of ????? marks on serial console once the kernel gets run from
> "ppcboot", and then I start GDB with cmd "target remote /dev/ttyS0" on the
> host. The GDB got messages like "Ignoring packet error, continuing..." and
> then timeed out to close connection.

This is usually an indication that you tried to rn the  native  (x86)
GDB  which  will not be anle to communicate with a PPC target. Please
use the PPC cross version of GDB instead (ppc_8xx-gdb).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
He had quite a powerful intellect, but it  was  as  powerful  like  a
locomotive,  and  ran on rails and was therefore almost impossible to
steer.                          - Terry Pratchett, _Lords and Ladies_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
