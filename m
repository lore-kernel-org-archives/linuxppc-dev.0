From: "Jason Wohlgemuth" <jwohlgem@usa.net>
To: "Julia Elbert" <jelbert@enerdyne.com>,
        <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: HardHat  libraries for embedded systems
Date: Sat, 3 Jun 2000 21:12:53 -0400
Message-ID: <NCBBKJKKGDLPHKDPAFFMKEGJCFAA.jwohlgem@usa.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <67505026E29DD311A9AA00508B7315F31955B4@EXCHANGE>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia,

Look on the embedded ftp site for a minroot tarball.  That would be a good
guideline for which libraries you need.  About the make config, I believe
the RPX classic and RPX lite are two different boards made by embedded
planet, I don't think the "lite" implies a smaller kernel or set of
libaries, so if I were you, I would stick with your current working kernel
config and try to put together a minroot similiar the the tarball.

Hope that helps,
Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Julia
Elbert
Sent: Saturday, June 03, 2000 9:01 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: HardHat libraries for embedded systems



Hi All,
I am trying to make a ramdisk.image to burn in flash on an 860 using the
hardhat 2.2.13-7. I get errors can't load libc.so.6. What libraries do I
need and how do I make them small enough?

Also, do I make config and switch to RPX Lite to build my kernel or stick
with RPX Classic and just the options I need?

Thanks in advance. This is a great users group!

--Julia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
