Message-ID: <3D4E1E5A.1070206@gmx.de>
Date: Mon, 05 Aug 2002 08:42:34 +0200
From: Michael Habermann <MHabermann@gmx.de>
MIME-Version: 1.0
To: Narendra <narengh@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CS_BAD_VCC Error during Card Configaration.
References: <20020805043039.4380.qmail@webmail6.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Narendra wrote:
>
> But as i found through debug message, socket is configured for
> 5volts and the CIS read from my card wants 3.3V. So my Config()
> routine is failing since there is a mismatch in configured Vcc and
> Requested Vcc. and Kernel is crashing.
>

You are using a 3.3V card in an 5V socket. If the card can do this - and
I think Prism 2 can - you  can bypass the code which checks if the Vcc
is correct. You will maybe find it if you look in the WLAN drivers
source code and search for conf.Vcc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
