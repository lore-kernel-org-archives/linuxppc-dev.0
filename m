Message-ID: <67505026E29DD311A9AA00508B7315F31956F6@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'greyham@research.canon.com.au'" <greyham@research.canon.com.au>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: reboot
Date: Thu, 14 Sep 2000 08:26:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Very cool, I did not think of using the ioctls.
I will try it out.
Thank you.
--Julia


		You don't need to reboot to change the IP address and
routing.

		Use the SOICSIFADDR, SIOCSIFNETMASK, SIOCSIFBRADDR ioctls on
a PF_INET socket
		with the appropriate ifr_name (probably "eth0") to change
the IP address.

		Use SIOCDELRT and SOICADDRT to delete and add routes.

		No reboot required!

		Regards,
		Graham
		--
		Graham Stoney
		Principal Hardware/Software Engineer
		Canon Information Systems Research Australia
		Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

		** Sent via the linuxppc-embedded mail list. See
http://lists.linuxppc.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
