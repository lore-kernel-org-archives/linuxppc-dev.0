To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial-to-socket conversion 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 May 2004 18:26:41 +0200."
             <20040525162646.A291FC109F@atlas.denx.de>
Date: Tue, 25 May 2004 19:10:52 +0200
Message-Id: <20040525171057.11952C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040525162646.A291FC109F@atlas.denx.de> I wrote:
>
...
> We're running a modified version of netkit-rsh which  allows  to  use
> "rlogin <host> -l <portname>" to connect to a remote serial port; for
> example, this config file might be used:
...
> If you want I can send you the stuff; if ther eis more interest I can
> put it on our FTP server.

OK, OK, OK - please stop sending requests...

You can find our "terminal server" package at

	ftp://ftp.denx.de/pub/tools/tserver-0.17-3.i386.rpm
	ftp://ftp.denx.de/pub/tools/tserver-0.17-3.src.rpm

The first is a RPM for RH 9; the second is the Source RPM.

As mentioned before, this is an extension/add-on  to  netkit-rsh-0.17
which requires the following acknowledgement:
	This product includes software developed by the University of
	California, Berkeley and its contributors.
Our extension itself is available under GPL.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Data is a lot like humans: It is  born.  Matures.  Gets  married  to
other  data, divorced. Gets old. One thing that it doesn't do is die.
It has to be killed."                                 - Arthur Miller

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
