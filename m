Message-ID: <008801c1bf30$d6642fb0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Kerl, John" <John.Kerl@Avnet.com>
References: <C08678384BE7D311B4D70004ACA371050B7632EC@amer22.avnet.com>
Subject: Re: execve system call question
Date: Wed, 27 Feb 2002 10:48:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kerl, John

> I found on this mailing list that the IMMR must be located
> *above* 0xc0000000.  For example, 0xf0000000.

The MPC755 doesn't have IMMR.
If it means all the I/O should be located above 0xf0000000 please let me know.
My board has a serial port at 0x78000000.

Thank you!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
