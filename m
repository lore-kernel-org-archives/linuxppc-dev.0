Message-ID: <3FC39A87.4060701@mvista.com>
Date: Tue, 25 Nov 2003 11:08:07 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Davis <bmdavis@arlut.utexas.edu>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gt-64260 Question
References: <3FC3945E.9090506@arlut.utexas.edu>
In-Reply-To: <3FC3945E.9090506@arlut.utexas.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Benjamin Davis wrote:

>
> Is anyone familiar how to set the QACk delay on the 64260 system
> controller, specifically on an mvme5500 board.

There are several 'delays' referred to in the gt64260 manual, none of
which are a QACK (AFAICT).  Do you mean AACK?  If not, are you sure its
not a field in a board registers?

> I am trying to work
> around a bit of errata noted in the mpc7450 family chip errata.  Also,
> does anyone know were to find information on ths gt-64260, marvell is
> not forthcoming in providing information.

This is a true statement.  My company had to sign an NDA before I could
see any manuals and I'm not sure just anyone can get an NDA from Marvell.

If you provide some more info, I may be able to help you.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
