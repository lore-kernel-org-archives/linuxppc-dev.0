Message-ID: <B895EFF5AF34724880036BDB5B5B81481356F5@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'j.rakesh@gdatech.co.in'" <j.rakesh@gdatech.co.in>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux porting to IBM405 based board
Date: Thu, 19 Jun 2003 08:46:48 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For control-C, you might check your terminal emulation
program.  Window$-based ones typically consume ^C for
the Copy function.  Does control-\ work?

For backspace, does the delete key work instead?  If so,
you might check out the manpage for stty.

-----Original Message-----
From: Rakesh jagota [mailto:j.rakesh@gdatech.co.in]
Sent: Wednesday, June 18, 2003 8:58 PM
To: Linuxppc-Embedded
Subject: Linux porting to IBM405 based board



Hi all,
I am able to port linux in IBM based power pc 405. I have few issues. I am
not able to kill the process using "ctrl-c". I am not able to use
"backspace"
key to delete the character. Can anyone help me out sort out these silly
issues.


Thanks & Regards,

Rakesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
