Message-ID: <762A181C0D966E459A2EB3B810142C770386152B@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'Mark Chambers'" <markc@mail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: more questions about 8xx microcode patches
Date: Tue, 27 Jul 2004 17:44:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was working with Motorola about a year ago on USB on the MPC850.  At that
time, we were already using the I2C/SPI relocation patch.  The word from the
factory was that you couldn't use more than one microcode patch at a time on
an '850.  I doubt this has changed since then.  There was a first attempt at
a single patch for I2C/SPI relocation combined with USB.  I don't know if it
was ever released.

Regards,
Charlie

-----Original Message-----
From: Mark Chambers [mailto:markc@mail.com]
Sent: Tuesday, July 27, 2004 5:07 PM
To: Robert P. J. Day; Embedded Linux PPC list
Subject: Re: more questions about 8xx microcode patches



Robert,

I know I've never had a need to use a microcode patch.  Maybe a quick
survey - has anybody ever had a need to use two patches at once?  I'm
suspecting you may be putting a lot of effort into something that's rarely
needed.  Also, as Motorola updates their silicon the patches will likely
become less relevant (less likely that new users will need the patches).

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
