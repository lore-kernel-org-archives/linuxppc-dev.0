Message-ID: <20010918172732.56517.qmail@web11002.mail.yahoo.com>
Date: Tue, 18 Sep 2001 10:27:32 -0700 (PDT)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: PowerMac 8500 2.4 kernel with ext3+ACL, PlanB, raid1
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi all.  I am sending this in the hope that someone else already has this
configuration or can give any pointers at all because I've been mostly
unsuccessful at compiling any ppc Linux kernels at all.  I have a fully
functional 2.2.19 from the standard Linus tree, and a partially functional
2.4.10-pre6-ben0.  2.4.10-pre2-bk won't compile for me.

	Here are my current kernel configs.

	http://mmmgood.net/doc/2.2.19_config.text
	http://mmmgood.net/doc/2.4.10-pre6-ben0_config.text

	I'd like any version of a Linux 2.4 kernel source tree for my 8500 with the
following features in order of preference.  Thank you very much for any
direction you can contribute.

* software raid1

	* module or static, with autodetection.  Mine works fine statically but not
modularly, and it works just fine.

	* canonical dist _seems_ to be at http://people.redhat.com/mingo/raid-patches/
and http://people.redhat.com/mingo/raidtools/ and might be newer than the code
in the canonical kernel distribution

* PlanB AV driver

	* The canonical dist is definately at http://mcp.cpu.lu/~mlan/planb.html and
Michel just made a recent update, which he propagates to BenH and AlanC.  He's
been in communication with me but he doesn't fully test recording features, nor
are they all completely mapped to the Video4Linux API.  I'm not sure if all
PlanB features are implemented at all.  My current setup supports pass-through
viewing but no recording of snapshots or movies for some unknown reason, using
v4l's utilities.  I await a response from Michel regarding whether the
canonical kernel's planb driver or the patches on his site, are the best to
use.

	* I would like fully stable, sustained (30-120 mins per file a time), full
quality audio/video recording if possible.  I have the disk space and disk
speed.  It'll have to be uncompressed because my 180 MHz 604 isn't fast enough
for realtime compression.

* ext3 and ACL

	* After I scoured mailing list entries via google.com, the canonical dist
seems to be at http://www.moldybread.net/patch/kernel-2.4/ but consists only of
patches applied to an AlanC tree and I don't know if it's IA32 oriented or what.

=====
Medium System Administrator and Junior I.T. Manager of 5 yrs
 -- Now available -- Linux, MacOS, Unix-like systems
    -- http://mmmgood.net -- dan_bethe@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
