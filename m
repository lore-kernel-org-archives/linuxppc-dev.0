Message-ID: <EFB813091B18D511BD3600508B644F820A617EC9@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'Brian Hawley'" <bhawley@luminex.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: baud rate question
Date: Thu, 13 May 2004 17:40:22 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did you change you terminal settings to 38400 baud rate?
There's also a separate environment variable "baudrate".
Please, display your env vars with "printenv" command and make sure your
baudrate env var equals 38400:
baudrate=38400

I forgot to mention a change at your /etc/inittab file at your kernel root
directory. Make sure you're setting 38400 baud rate there as well.

Hope this helps.
Regards,
Adam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
