Message-Id: <s88831d7.021@mail.frequentis.com>
Date: Fri, 21 Jan 2000 10:15:21 +0100
From: "Ralf HECKHAUSEN" <RHeckhau@frequentis.com>
To: "<"<linuxppc-embedded@lists.linuxppc.org>
Subject: UART driver problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a strange problem with the uart driver. The 8xx_write in uart.c always fails because copy_from_user returns 0 instead of the requested number of bytes. When I ignore the comparison with the requested number of bytes everything works ok, the correct bytes are transmitted and 8xx_write returns something >0.
The next strange thing: a write to a tty file descriptor sometimes returns a negative number, although the output succeded. perror in this case outputs an unknown error.
Does anyone know this problems?

Ralf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
