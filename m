To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Nov 2003 15:34:11 GMT."
             <DEF39A0710293E489D45B10E06645CBD02671CA2@dub-msx1.spectelcorp.com>
Date: Thu, 20 Nov 2003 17:27:08 +0100
Message-Id: <20031120162713.A1C94C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DEF39A0710293E489D45B10E06645CBD02671CA2@dub-msx1.spectelcorp.com> you wrote:
>
> My problem is that I dont really know what address the core is trying to write to when the exception occurs.
> As I mentioned in the previous message, the write() calls _syscall3() macro which will perform the write operation, but early  in that macro the assembly 'sc' instruction is called.
> As I cannot step through 'sc', I cannot go further on investigating at what write access the exception occurs.

But you can set a breakpoint in the sc exception handler.

> How do I even find out what is the start address of the file associated with the file descritor?

Analyze at which offset the file starts  in  your  filesystem  image;
find  out  the  load  address of the filesystem image in RAM; add the
offset.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Love is an ideal thing, marriage a real thing; a  confusion  of  the
real with the ideal never goes unpunished."                  - Goethe

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
