Message-ID: <005801c1be60$88bcd8a0$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <200202252229.g1PMTdQ02395@xdr.com>
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Date: Mon, 25 Feb 2002 19:57:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(snip)
> The crucial thing is mmap some region of io space
> read from a page write to the same page
> Repeat and rinse, something will corrupt the system.
>
> reads alone are ok.
> writes alone are ok.
> write followed by any combination of reads or writes is ok
> read followed by write = trouble

I am an embedded PPC Linux novice, so, tell me if I'm way off base.
This sounds like a pipeline problem; out of order I/O execution.
Could there be an "eieio" missing somewhere?

Greg Griffes


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
