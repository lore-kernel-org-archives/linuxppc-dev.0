Date: Mon, 3 Dec 2001 18:04:48 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Max swap size ?
Message-ID: <Pine.LNX.4.33.0112031753420.21063-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Greetings,

 I have a machine running YDL (Dual 800Mhz, 1GB RAM) with a 2.4.13 SMP
kernel (YellowDog's stock SMP kernel) that has a 512 MB swap partition.
When I tried to install on other machines, they wouldn't boot with a swap
partition that big, but for some reason this one did. It wasn't until
after the other machines wouldn't boot did I notice in the TerraSoft docs
that 256MB was the max. The machine ran beautifully until today when it
did a nasty crash. My gut feeling is that it crashed when it tried to
write to the swap for the first time as it was inching up to using almost
all available RAM when it died.

 So my question is: Is this a likely cause and will resizing the swap
partition fix this or do I have bigger problems? Any info would be much
appreciated.

Cheers,

Chris

 P.S. Many thanks to all PPC Linux hackers. My servers and desktop
machines run beautifully because of your work. If any of you come to Mtl,
look me up and I'll take you out for a drink (Beer, coffe, etc.) and some
hospitality.

--

Christopher Murtagh
Webmaster / Sysadmin
Web Communications Group
McGill University
Montreal, Quebec
Canada

Tel.: (514) 398-3122
Fax:  (514) 398-2017


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
