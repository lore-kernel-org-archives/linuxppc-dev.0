Message-Id: <v0313030db436a6abe40d@[17.202.21.235]>
In-Reply-To: <v04210110b436a08c1576@[192.168.0.1]>
References: <3810680B.51E0FABD@iname.com> <3810680B.51E0FABD@iname.com>
MIME-Version: 1.0
Date: Fri, 22 Oct 1999 16:47:32 -0700
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
From: Peter Bierman <bierman@apple.com>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>in short this used to work on older G3s and apple just crippled it on
>the new ones to make their own life difficult along with ours.

Heheh. How true.

OF serves no one's goals beyond booting Mac OS. Anything else is good
fortune for those using it. The good news is that as new machines come out,
OF generally gets better at booting non-Traditional Mac OS things.

Mac OS X should make your lives easier.

I suggest a small HFS springboard partition. OF on all machines knows how
to find and boot an HFS volume. You can put a fake System folder with a
boot 2 resource, and a tbxi fake ROM image that acts as your booter.

Standard HFS is a pretty simple filesystem.

if you go with the above design, I predict you'll have a lot less work to
do to keep up with new hardware and OF versions.

I don't work on OF, so don't bother asking,
-pmb

--
"Apple is doomed. At some point the universe may collapse upon itself, and
 this would crush even the hard plastic shells of fast, high-capacity iMacs."
 - Minneapolis Star Tribune 10.19.99


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
