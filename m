Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.net.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id 1623567A71
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 17:32:41 +1000 (EST)
Received: from apogee.jonmasters.org ([212.18.227.82]
	helo=pat.int.jonmasters.org)
	by smtp.mailbox.co.uk with esmtp (Exim 4.44) id 1DIM4c-0005rb-U4
	for linuxppc-embedded@ozlabs.org; Mon, 04 Apr 2005 08:32:39 +0100
Received: from perihelion.int.jonmasters.org ([192.168.1.3])
	by pat.int.jonmasters.org with esmtp (Exim 3.35 #1 (Debian))
	id 1DIM3W-00088X-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 04 Apr 2005 08:31:30 +0100
Message-ID: <4250ED79.6010304@jonmasters.org>
Date: Mon, 04 Apr 2005 08:32:09 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Fwd: Re: Platform bus/ppc sys model - [Fwd: bi_recs and u-boot
	ppcboot.h]]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

- -------- Original Message --------
Subject: Re: Platform bus/ppc sys model - [Fwd: bi_recs and u-boot
ppcboot.h]
Date: Mon, 04 Apr 2005 08:28:39 +0100
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
To: Stefan Roese <sr@denx.de>
CC: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
References: <424BEECD.8020303@jonmasters.org>
<200504040844.34428.sr@denx.de>

Hi Stefan, other folks,

Sorry I've not replied to some of the other threads - suffice it to say
I've had a busy weekend hacking on an ecos HAL. Anyway, I'll get synced
up again today or tomorrow, just in time to jump on a plane to USENIX :-)

Stefan Roese wrote:

| The CPCI405 supports switching the boot-cs between its 2 flash chips
with the
| DIP-switch 4. You could copy the current ppcboot version into the 2nd
flash
| chip as a fallback (please test it once).

Oooh. I didn't know that (don't have the schematics here :P) - cheers.
I'll try doing that before I go away :-) If I can do this then I'll have
at least something vaguely sacrificial to work with here, I think the
current plan as discussed is vaguely worth persuing, even though it
might not be the optimal eventual solution. Will followup shortly.

What should happen is that OF trees get written like they do for mol and
then automagically converted in to a BLOB for use with u-boot - no, I
don't think this is the grand unified solution to everything, but I do
think it will persuade someone to find a cross platform solution.

FWIW Stefan, I am just setting up a similar power cycler setup to what
you guys have there - found a cheap supplier of wireless 13A mains
socket automation kits (<15EUR) in the local electronics store,
butchered remote control unit, sufficient for a cheapo cycler.

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCUO14eTyyexZHHxERAn31AKCX3oT4UEBkYqr9GLqiQzoIGRvSpQCfY04d
c1Pqq8NPCaGnMusZKKO1L/4=
=/2/9
-----END PGP SIGNATURE-----
