Date: Tue, 04 Apr 2000 22:22:32 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Setting up yaboot
To: linuxppc-dev@lists.linuxppc.org
Message-id: <38EACD97.113001FE@dana.ucc.nau.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <200004040459.XAA03713@lists.linuxppc.org>
 <38EA7D15.C453ED94@uncc.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there some sort of instructions to setting up yaboot?  I managed to
get LinuxPPC 2000 installed on my Pismo, and I'd like to actually be able
to use it now.  Here's how I have the partitions set up.

hda9 -> 2gb MacOS partition (HFS+)
hda10 -> 32mb HFS partition
hda11 -> 128mb swap
hda12 -> Rest of drive is linux "/"

Don't ask me why the partition numbers are so high, cuz I don't know.
Any help offered would be appreciated.

Tim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
