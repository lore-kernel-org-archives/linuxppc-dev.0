Message-ID: <B164B53F5BD6D511888D009027732E1A024A23@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'John W. Linville'" <linville@lvl7.com>,
	Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI2000 breakpoints in dynamically loaded modules
Date: Thu, 24 Jan 2002 09:06:26 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Just a guess...when you do the "add-symbol-file", do you specify the
> address for the .text (and possibly other) section(s)?  If you don't,
> I'm not sure what it will default to be, but it will almost
> certainly be
> wrong.
>
> When you do the insmod, use the -m parameter and redirect the
> output to
> the file.  Near the top of that file it will tell you where the .text
> section starts.
>


Yes, I specify the address.
If I do not, I will not be able to set a breakpoint.

Rudolf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
