Message-ID: <20030709045749.19312.qmail@web9705.mail.yahoo.com>
Date: Tue, 8 Jul 2003 21:57:49 -0700 (PDT)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: parallel I/O ports & opend darin pins on MPC8xx
To: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <FCEAKDJJAPHPLJFINDAJOEFEDEAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 I hope it is not a Hardware problem. Do you
need an external pullup? If you do not have one,
then the problem arises (had the same problem once).
Except if one of your peripherals actively drives
your input....

                       Cheers
                            Dimitris.

--- Stephan Linke <Stephan.Linke@epygi.de> wrote:
>
> Hi,
>
> on one of our boards we are using one of the I/O
> pins in open drain mode. This leads to some problems
> in combination with other
> drivers that write to the ports data register. Since
> they can not detect the current output value of the
> open drain pin. They only
> see the status of the I/O pin no matter who forces
> the value the CPM or another device connected to the
> open drain pin. After
> writing back the value read from the I/O data
> register this value is forced by CPM which is
> normaly wrong.
>
> Did anyone run into that problem in the past? What
> was your solution? Any thing else but NOT using open
> drain pins?
>
> Thanks, Stephan
>
>
>


=====
------------------------------------------------------------
-Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
 Greece.
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
