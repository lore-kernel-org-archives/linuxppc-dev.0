Content-Type: text/plain;
  charset="iso-8859-1"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem with MPC8260ADS ethernet sending
Date: Tue, 21 May 2002 20:54:18 -0400
References: <200205181141.38793.ADharankar@ATTBI.Com>
In-Reply-To: <200205181141.38793.ADharankar@ATTBI.Com>
MIME-Version: 1.0
Message-Id: <200205212054.18891.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings!

We have the problem solved by setting the full duplex bit in the
FPSMR, although I dont understand how this works. We have a
Linksys workgroup enet hub connected, and as I understand
the link should be half duplex - and should have worked ok
with the default configuration.

Anyway, the problem showed up with the same symptoms as I
described earlier - only 162 bytes of enet IP payload (total of
204 bytes) were transmitted ok in the half duplex mode, and
anything larger than that size just did not make it out.

It would be interesting to know why of the above, although this
solves the problem for me now.

Many thanks to those who responded!

Best regards,
-Arun.



On Saturday 18 May 2002 11:41 am, Arun Dharankar wrote:
> Greetings.
>
> On Motorola MPC8260ADS board (as it is), I have ppcboot (1.1.5)
> and Linux (2.4.18 and 2.4.19-pre8 both). The network interface is
> lxt970 on fcc2. Receive data  is ok (perhaps a bit slow).
>
> When I try to send data out of the board, I see that as long as the
> buffer size if less than or equal to 160 bytes, the send is ok. Any
> buffer size above 160 bytes (even 161), the buffer does not make
> it out of the host.
>
>
> The above test is with a UDP program. A ping flood from another
> host does not seem to cause a problem. Likewise, if I use ftp to
> get files to the board, it works ok (again slow), but send of files
> will fail after sending some data.
>
>
> Any pointers to the solution, hints, strategies to debug this would
> be very helpful.
>
> Thanks in  advance.
> -Arun.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
