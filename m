Message-ID: <3B9CD8F1.D0BE6F61@mvista.com>
Date: Mon, 10 Sep 2001 08:14:57 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Anthony Tsui <Tsui_Anthony@hotmail.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can hhl2.0 run on Redhat 7.1?
References: <OE54iDd9D9DQVXwR1IM000013fe@hotmail.com> <20010910075048.A11013@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,
An easier solution is to change the redhat-release file in /etc
to read 7.0. Then do the install and change the file back.
Cal


Tom Rini wrote:

> On Mon, Sep 10, 2001 at 03:31:34AM +0200, Anthony Tsui wrote:
>
> >    Can hhl2.0 run on Redhat 7.1?
>
> Yes, but it's not supported.  Read the hhl-host-install script and look for
> the bits which make sure it doesn't install on RH7.1
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
