MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: VirtexIIPro, caches
Date: Tue, 4 May 2004 11:59:00 -0700
Message-ID: <C7FFFEA58B43D311920D0004ACE5333F132B01B8@amer25.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "emanuel stiebler" <emu@ecubics.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Emanuel,

Without the MMU on, please check the ICCI and DCCI registers.
These give 128 MB resolution.

With the MMU on, caching is on a per-page basis; check the
TLB_W and TLB_I flags of each TLB entry.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]
Sent: Tuesday, May 04, 2004 8:41 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: VirtexIIPro, caches



Hi all,
is there an easy way to check if the caches are all enabled ?
I have some performance problems and I'm trying to figure out
where it is coming from ...

cheers & thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
