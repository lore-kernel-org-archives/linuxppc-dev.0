From: christopher.murtagh@wcg.mcgill.ca
Date: Fri, 16 Feb 2001 00:40:56 -0500 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mmu_context_overflow
In-Reply-To: <19350110155919.4689@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.21.0102160021250.5346-100000@saraswati.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Feb 2001, Benjamin Herrenschmidt wrote (regarding mmu
overflow):
>No, I don't think you should worry about these. those messages simply
>need that the kernel ran out of VSIDs and had to re-assign them all. It's
>perfectly harmless as long as it doesn't happen too often.

Thanks very much for the info Ben. So far I have only seen it once. Knock
on wood.

regarding eth0 transmit timeouts:
>I'm more concerned about your network problems however. I beleive the
>chip is a GMAC chip with a 5201 PHY (can you confirm ?). With 2.2.18,
>you should not have transmit timeouts. If you have some, then there's
>either a bug in the driver (which seemed to be rock-solid so far) or, we
>are hitting a HW issue.
>
>Does the gmac driver display some version informations when the kernel boots ?

Here is the info I pulled out of my last boot log:

eth0: GMAC at 00:30:65:44:e2:ee, driver v1.3k2
eth0 PHY ID: 0x00406212
eth0 Found Broadcom BCM5201 PHY

 I usually get 3 of these a day, sometimes 2, sometimes 4, mostly they
coincide with really high traffic periods (150k http request per hour -
this server is 99% http traffic), but I have had some at what seem to be
low traffic periods (but this is rare).

 I haven't seen this on any of our other G4s, but none of them are taking
on anywhere near that amount of traffic. Do you suspect it might be a
hardware problem with this particular machine?

Cheers,

Chris

info about the machine: http://www.mcgill.ca/secretaboutbox/

--

Christopher Murtagh
Webmaster / Web Communications Group
McGill University
Montreal, Quebec
Canada


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
