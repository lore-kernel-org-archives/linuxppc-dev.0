Message-ID: <002001c1c31a$cf2a0c90$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Kerl, John" <John.Kerl@Avnet.com>
References: <C08678384BE7D311B4D70004ACA371050B7632EF@amer22.avnet.com>
Subject: Re: execve system call question
Date: Mon, 4 Mar 2002 10:20:44 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kerl, John,

I got the bash prompt

I changed the hardware with some jump wire so that the serial port is located at 0xff000000.

Thank you!
- Sangmoon Kim -

----- Original Message -----
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Sangmoon Kim'" <dogoil@etinsys.com>
Sent: Thursday, February 28, 2002 1:51 AM
Subject: RE: execve system call question


> I do not know for certain that all I/O must be above 0xc0000000.
> However, I do know once I moved all my I/O above 0xc0000000,
> my board no longer hung while starting init.
>
> Note that 0xc0000000 and up is used for kernel RAM.  So, don't
> put a device at 0xc0000000.  And you may have flash around
> 0xfff00000; if so, that is another place to avoid.
>
> I would strongly suggest moving your serial port to, say, 0xf0000000.
> I do know that your symptoms resemble the symptoms that I saw,
> and that at least two other people saw.
>
> Can you try it out?
>
> -----Original Message-----
> From: Sangmoon Kim [mailto:dogoil@etinsys.com]
> Sent: Tuesday, February 26, 2002 6:48 PM
> To: linuxppc-embedded@lists.linuxppc.org; Kerl, John
> Subject: Re: execve system call question
>
>
>
> Hi Kerl, John
>
> > I found on this mailing list that the IMMR must be located
> > *above* 0xc0000000.  For example, 0xf0000000.
>
> The MPC755 doesn't have IMMR.
> If it means all the I/O should be located above 0xf0000000 please let me
> know.
> My board has a serial port at 0x78000000.
>
> Thank you!
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
