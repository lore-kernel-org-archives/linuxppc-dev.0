To: danieltaylor@acm.org
Cc: David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: BDI2000 Jtag interface questions... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Oct 2003 03:56:16 PDT."
             <3F8BD650.5020901@comcast.net>
Date: Tue, 14 Oct 2003 13:34:47 +0200
Message-Id: <20031014113452.F18B0C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F8BD650.5020901@comcast.net> you wrote:
> He may have meant doing JTAG boundary scans.  I would think
> that if you can program flash/eproms, that there is enough
> control to do a scan.  It depends on whether the BDI allows
> address/data level control in some sort of scripting language.

No. On MPC8xx you see a BDM interface. Essentially this is a  way  to
communicate  with  the CPU, i. e. to insert instructions into the CPU
core, have them executed, and get data back.  This  way  you  can  of
course  read  and  write  memory, too, or execute a flash programming
algorithm.

You cannot do anything like a boundary scan over BDM.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Der Dativ ist dem Genitiv sein Tod.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
