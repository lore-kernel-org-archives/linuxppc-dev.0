Message-ID: <3B74AB68.DEA5B56E@mvista.com>
Date: Fri, 10 Aug 2001 23:50:00 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Elan Feingold <elan@nxnetworks.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8255 vs MPC8260?
References: <NDBBLJKOJGKDOFBHNPGEKEGMCEAA.elan@nxnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Elan Feingold wrote:

> We're going to be using an MPC8255 processor, and I know there are a few
> differences between that CPU and the 8260 (e.g. less clock speed, less SCCs,
> etc.).

I haven't noticed any differences that would affect Linux.

> Has anyone run Linux/PPC on an 8255?

no reports.

> What needed to change from the standard 8260 port?

Just don't configure the devices that don't exist.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
