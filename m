Message-ID: <C78540EA349B2D4BB83D1B0AD748E26F1BE47C@amer20.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Conn Clark'" <clark@esteem.com>,
	Aman <aman@mistralsoftware.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Time
Date: Fri, 7 Mar 2003 10:06:06 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A stopwatch or the time command will tell you the
total time.  But if you want to find out *where*
the time is being spent, please don't forget gprof.
(I don't know if an embedded version is available.)

-----Original Message-----
From: Conn Clark [mailto:clark@esteem.com]
Sent: Friday, March 07, 2003 10:04 AM
To: Aman
Cc: May Ling List
Subject: Re: Time



Aman wrote:
> Hi
>
> Can anybody suggest the best way to calculate the time taken by an
> application, running on PPC 440.
>
> Thanking you in advance
> regards
> Aman
>
>
>

There is a program called 'time' . It is used time and gather statistics
of a program. See the man page.


Good Luck

	Conn

--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
