Date: Thu, 6 Jul 2000 22:33:37 -0400 (EDT)
From: Brighten Godfrey <godfreyb@bigw.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel panic from network apps
Message-ID: <Pine.GSO.4.10.10007062232000.23698-100000@hamlet.bigw.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm having a kernel panic problem; no one knew anything about it on
comp.os.linux.powerpc so I thought I'd ask here.  To summarize, I'm
getting a kernel panic whenever I transfer moderate amounts of data to
my machine from remote hosts.  Now here are all the details.

My hardware:
    AGP G4/350
    IDE drive partitioned with Mac OS 9.0.4, LinuxPPC 2000
    SCSI drive with LinuxPPC 1999
    SCSI drive with Mac OS 9.0
    Network connection: DSL

My software (I've tried various configs, all have the same problem):
    LinuxPPC 1999 (kernel 2.2.15pre3),  BootX 1.1, Mac OS 9.0
    LinuxPPC 1999 (kernel 2.2.15pre3),  Yaboot,    Mac OS 9.0.4
    LinuxPPC 2000 (kernel 2.2.15pre3),  Yaboot,    Mac OS 9.0.4
    LinuxPPC 2000 (kernel 2.2.15pre19), Yaboot,    Mac OS 9.0.4

What *doesn't* crash the machine:
  * In Mac OS, Any network operation
  * In Linux, Anything that doesn't use the network
  * In Linux, any network operation to/from other machines in my
    house (connected via ethernet).
  * In Linux, any file transfers (ftp) *to* remote hosts
    outside my DSL connection
  * In Linux, *small* file transfers *from* remote hosts outside
    my DSL connection (e.g., a typical telnet session or a
    lightweight web page like Google.com)

What *does* crash the machine:
  * In Linux, large file transfers from remote hosts outside my
    DSL connection (e.g., ftp'ing a large file to my computer,
    or loading a complicated page like Slashdot in Netscape).

Here's the kernel panic message:

    Kernel panic: skput:over: c00fccf4:1626 put:1626 dev:eth0
    In swapper task - not syncing
    Rebooting in 180 seconds..

I did have this machine running with LinuxPPC 1999 (kernel 2.2.15pre3,
BootX 1.1, Mac OS 9.0) for 4 months from my college dorm last semester.
without any problems. That was with ethernet and a fast net connection.
When I brought it out to my summer residence with DSL is when it stopped
working, but I don't know that the DSL was what caused the problem,
since several other things changed as well at the same time:  I upgraded
to Mac OS 9.0.4, which caused me to also have to switch to Yaboot
instead of BootX.

I'd appreciate any clues as to what causes this problem, any ideas about
how to fix it, more things I could test, or other people's experiences
with this problem.  Basically any information at all. :-) No one else
seems to be seeing this kernel panic, so I really don't know how to
proceed right now other than checking out the kernel source.

Thanks very much for any help you can provide and for your time
reading this probably overly-long message. :-)

Brighten Godfrey
______________________________________________________________________
Brighten Godfrey | godfreyb@bigw.org | godfreyb@cmu.edu | 651.405.9235


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
