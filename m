Message-ID: <3B969EDE.58143637@mvista.com>
Date: Wed, 05 Sep 2001 14:53:34 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Navin Boppuri <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ctrl-C does not work
References: <3A494DE356A49A40B37442E1E0D9F3B506343E@ptah.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin,
Take a look at the /dev/console entry. In one it is a link to
/dev/ttyS0 in the other it isn't. At one point it should have
been the link. That is what makes it work. It was a feature
that is a disguised bug. It was fixed in HHL 2.0

Cal Erickson

Navin Boppuri wrote:

> Hello everyone,
>
> Ctrl-C does on work on my serial console when I use the sample file
> system from Hardhat 1.0 toolkit. It , however, works with the Hardhat
> 1.2 toolkit sample file system. I am using the same kernel to test both
> the file systems. What could be different between these two file
> systems?
>
> Thank you,
> Navin
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
