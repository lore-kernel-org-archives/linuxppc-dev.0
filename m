From: "Naushit Sakarvadia" <Naushit_Sakarvadia@quintum.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 8 Bit Mem read with gdb
Date: Mon, 23 Jul 2001 11:10:13 -0500
Message-ID: <000d01c11391$f519d0e0$7802a8c0@QUINTUMCHI.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

This is regarding PowerPC 8260 gdb.

My question is how do I tell gdb to read a byte only  while reading
0xfff00100..0xfff00500 address range.
While  checking mem I use  "x /b  0xfff00100" and it works fine , but while
I do unassamble from this address it tries to read a word from this
location, and as a result the first byte is repeated 4 times.It is 8 bit
wide flash mem,so
you cant read a word at a time.

So I want to tell gdb to do byte wide reading while doing unassambling and
all other operations.

Please reply me personally, I am not on gdb mailing list.

Thanks
Naushit


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
