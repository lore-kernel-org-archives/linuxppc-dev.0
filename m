Date: 13 Nov 2001 08:17:39 -0000
Message-ID: <20011113081739.29856.qmail@mailweb25.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: IDE in Mode 1 (Sandpoint) how ?
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Dan,

> Nope.  All of the kernel print out is polled I/O.
>
  yeah ! Thats right.

>me: .....  But thats
>me: not the case. Why should it be slow after INIT
>me:starts
>me: up ?
>
> Because it uses interrupt driven serial I/O.

  I'am currently investigating that code path, Dan.
  We have also come to the same conclusion as u.
  But believe me, I had tried with all possible
  Switch settings, S3,S4,S5,S6. :-( Its tantalising !
  This means that all ISA interrupts are not
  being routed properly. One more, I haven't
  initialized the WinBond, coz reset values seem
  meaninful. Could that be the reason for
  this ?
>
> Believe me, all of us using Sandpoints have seen this
> before.
> Your interrupt/arbitration routing switches on the
> board are wrong.

  Any suggestion from experienced people is welcome.


Is there any other switch, other than the S3,S4,S5,S6
I need to worry about.

sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
