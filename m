Message-ID: <37EFF9B5.EE6BC3D6@baysystems.com>
Date: Mon, 27 Sep 1999 19:11:50 -0400
From: Noah White <noah@baysystems.com>
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Custom distribution/installation question
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I need to jumpstart several systems. I'd like to create a bootable CDROM
which I
can drop into the CD and walk away from while it loads a subset of RPMS
and does some vanilla configuration. Basically the Redhat installer in a
non interactive,
totally CD contained install.

Looking through various docs. it looks like perhaps a combination of
mkisofs, mkkickstart would work. What do I need to hack to build the
installable CD?
I assume I would only need the stuff under RedHat. Taking a look at that
I see an

instimage directory:    any details on its' purpose? Is this a bootstrap
for the install process?

base directory:    the base install? any pointers on info related to its
contents?

RPMS:    pretty self explanitory ;-)

Thanks in advance!

-Noah


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
