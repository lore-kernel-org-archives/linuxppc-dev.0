Date: Fri, 25 Feb 2000 13:48:50 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Ralf HECKHAUSEN <RHeckhau@frequentis.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: no serial console
In-Reply-To: <s8b6c9c1.032@mail.frequentis.com>
Message-ID: <Pine.LNX.4.21.0002251347050.11352-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Ralf!

> For a certain application we need all serial ports. Is it possible to
> have no serial console? Even if I undefine CONFIG_SERIAL_CONSOLE, I
> still need to have to link /dev/console link to a ttySx. Otherwise I
> cannot log in through telnet. How can I define /dev/console without
> using a serial port?

Hint: /dev/null

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
