To: Kumar Gala <kumar.gala@motorola.com>
Cc: Prakash kanthi <pkanthi@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC 405 port complains about 'tlbwe' opcode 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Oct 2002 15:28:50 CDT."
             <348359E2-E78F-11D6-A3F7-003065BFB10E@motorola.com>
Date: Thu, 24 Oct 2002 23:06:38 +0200
Message-Id: <20021024210643.4DF4F1014C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <348359E2-E78F-11D6-A3F7-003065BFB10E@motorola.com> you wrote:
>
> You need to pass down to the assembler an option to enable 403/405
> instructions.  Add a -Wa,-m405 to the gcc line.

Actually the cross compiler should automatically  set  the  necessary
options  for  the  target,  or you might run into problems because of
missing or inconsistent options for your compiles (kernel, libraries,
applications) - "-msoft-float"  is  another  candidate  for  such  an
option.

> > Please suggest. If you can share a PPC-405 port for
> > linux or any other embedded free OS, please let me
> > know.

for 4xx systems the linuxppc_2_4_devel tree  is  recommended;  either
fetch  it  from the BK server, or form our CVS server. We also have a
working set of cross and native tools  available  for  free  download
(ELDK - soon available in version 2.0).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Microsoft Multimedia:
You have nice graphics, sound and animations when the system crashes.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
