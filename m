Message-ID: <20000316193235.9637.qmail@web1201.mail.yahoo.com>
Date: Thu, 16 Mar 2000 11:32:35 -0800 (PST)
From: Calum Robinson <calum_robinson@yahoo.com>
Subject: title bar colors in kde fixed?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I edited the source file gradientFill.C to fix the
colors of the title bars in KDE. They were drawing the
wrong colors.

It should read (you'll find it)
 *p++;
 *p++ = blue >> 16;
 *p++ = green >> 16;
 *p++ = red >> 16;

I know its a silly bug but if it annoyed anyone else
there it is. I think its a Little/Big endian
conversion problem.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
