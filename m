MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Unexpected sleep on old iBook
Date: Tue, 19 Nov 2002 08:43:22 +0100
Message-ID: <2C5637A6A7CE844EA3C0A94565479F520BCD90@dest-as20-002.int.bauer-partner.com>
From: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since kernel 2.4.20-rc1 (and possibly some versions before)
my iBook (first generation) goes to sleep when I use pmud.

I fetched the latest pmud I could get (1.1.1.1 2002/12/07 11:31:46 sleemburg)

I use pmud -s (if that matters at all).
I set "lid_wakeup=0" in boot.local via /proc/pmu/options.

The logs do not show any clue why the kernel puts the iBook to sleep.
I feel that pressing keys keeps the iBook from sleeping, but
running processes or usage of the track pad do not.
This does not change when the Box in on AC or on Battery.

I rsynced against source.mvista.com yesterday (2002-11-18)
(no space for a Bitkeeper tree :-| )

Can someone help ?

Thanks

klaus.halfmann@t-online.de, 		(49)-(0)-6172/492497
Klaus Halfmann, Mainstrasse 8, 61352 Bad Homburg GERMANY


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
