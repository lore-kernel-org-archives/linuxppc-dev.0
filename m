Message-ID: <3B850C37.686E9D91@mvista.com>
Date: Thu, 23 Aug 2001 08:59:19 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <subodh@best.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Off-topic] Installing hardhat Journeyman edition on non-redhat
 machine
References: <200108230551.WAA24572@shell9.ba.best.com> <3B850AE1.E665920F@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:

> .....
>
> Now as I stated earlier these are just symbolic links in here.. if you
> back up to the cd2 directory, you will see a ppc_8xx/ directory.  This
> has the same structure as the install directory and is where the actual
> files live.  (I would suggest you install from the symbolic links
> though, as there may be conflicting files in the raw architecture
> directories, so the symbolic links are there to setup a default.)

(Sorry to spam the list again, but I forgot...)

If you can please use the installer.  (I.e. on a redhat system)  It will
simplify things greatly, and you are less likely to end up with a non
working system.  If you only want the cross tools, go ahead and just
install the RPMs.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
