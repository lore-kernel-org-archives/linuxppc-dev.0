To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: "mkimage" not found 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Mar 2004 11:33:33 +0100."
             <00a101c401d4$26140fc0$0400a8c0@portatile>
Date: Thu, 04 Mar 2004 12:07:37 +0100
Message-Id: <20040304110742.949A1C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <00a101c401d4$26140fc0$0400a8c0@portatile> you wrote:
>
> With the previous ELDK2.0 I would have generated the image with the "make
> pImage" command while now I suppose the command "make uImage" must be used.
> Is this correct?

This is correct, but "make pImage" will still work, too.

> Then at the end of compilation process, I have the following message:
> "mkimage" not found - U-boot Images will not be built.

The "mkimage" should be in your PATH when using the ELDK  -  it  gets
installed in /opt/eldk/usr/bin/

> Anybody has an idea where I am wrong?

Maybe your PATH ist not correct?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Felson's Law:
	To steal ideas from one person is plagiarism; to steal from
	many is research.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
