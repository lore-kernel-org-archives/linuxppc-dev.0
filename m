Subject: Re: reboot
To: jelbert@enerdyne.com (Julia Elbert)
Date: Thu, 14 Sep 2000 12:53:56 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
In-Reply-To: <67505026E29DD311A9AA00508B7315F31956F4@EXCHANGE> from "Julia Elbert" at Sep 13, 2000 06:39:53 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000914015356.9A7DDB6@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert writes:
> I need to be able to change ip address and routing on the fly, not using the
> console port to do it.

You don't need to reboot to change the IP address and routing.

Use the SOICSIFADDR, SIOCSIFNETMASK, SIOCSIFBRADDR ioctls on a PF_INET socket
with the appropriate ifr_name (probably "eth0") to change the IP address.

Use SIOCDELRT and SOICADDRT to delete and add routes.

No reboot required!

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
