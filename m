Message-ID: <001301c1c319$8ce6a8d0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Derrik Weeks" <derrikW@iotech.com>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <E0A487F3EEFFD111A3C5004033933F9ABBF6CA@postoffice.iotech.com>
Subject: Re: execve system call question
Date: Mon, 4 Mar 2002 10:11:40 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Derrik Weeks,

I got the bash prompt.

> A little research says this is not the case.  As I understand it (with thanks
> to Wolfgang) Linux reserves memory space below 80000000 for user
> applications.  In my case I had my IMMR based registers mapped below this
> value, and the kernel was setting mapping for this space to virtual =
> physical, which caused my problem.  You may have the same issue with your
> serial port, it would be worth a try to move it to high memory and see if
> this resolves your problem.

I changed the hardware by some jump wire, so the serial port is now located at 0xff000000.
I'll try the virtual != physical thing with my original hardware.

Thank you for the reply!
- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
