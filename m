Message-ID: <003601c02397$670ccd60$0a00010a@paoloweb>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Custom serial keyboard: playing dirty with the serial console
Date: Thu, 21 Sep 2000 08:44:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We have a custom IR keyboard & mouse, that i have attached to the serial
port of my board (i have an embedded powerpc). Its protocol is called 4PPM,
and i had to write a driver that intercepts these serial characters, decodes
and convert them to standard XT scancodes.

Serial routines were implemented, yet, and i decided to 'insert' my 4PPM
layer inside of the serial console driver.

Everything is now ok: i receive correct packets, convert them to XT
scancodes and call 'handle_scancode' to process them.

But 'handle_scancode' only prints characters to the console, without
apparently processing them. I see everything i write, but when i press enter
(scancode 0x1c), i only see a new line in the console, not any new bash
prompt.

Why this? Is it correct to intercept the serial console and not returning
single characters from inside it but from 'handle_scancode' mode?

Who know that?

THANX!

- may the pinguin b with u -

Have a nice day,
Paolo Scaffardi.
AIRVENT SAM s.p.a. - RIMINI - ITALY

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
