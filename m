Date: Fri, 7 Mar 2003 11:30:29 +0100 (CET)
From: Samuel Ortiz <samuel.ortiz@smartdata.ch>
To: =?X-UNKNOWN?Q?Callebaut=2C_Beno=EEt?= <benoit.callebaut@barco.com>,
	<aman@mistralsoftware.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Time
In-Reply-To: <81A66F72DCACD511B0600002A551BFCB4E9D60@kuumex05.barco.com>
Message-ID: <Pine.LNX.4.44.0303071129230.11829-100000@jourdain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In userland, calling "time your_app" helps too.

Cheers,
Samuel


On Fri, 7 Mar 2003, [iso-8859-1] "Callebaut, Benoît" wrote:

>
> In user mode, you can use top. Otherwise in the program, get_time_of_day or
> in kernel get_jiffies must work
>
> -----Original Message-----
> From: Aman [mailto:aman@mistralsoftware.com]
> Sent: Friday, March 07, 2003 11:05 AM
> To: linuxppc embedded
> Subject: Time
>
>
>
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


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
