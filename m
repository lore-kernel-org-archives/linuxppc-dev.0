Message-ID: <394CEDB7.7DB0D5A1@golden.net>
Date: Sun, 18 Jun 2000 11:41:43 -0400
From: hendricks <hendricks@golden.net>
Reply-To: khendricks@ivey.uwo.ca
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, yellowdog-general@lists.yellowdog.com
Subject: Need for Cross Platform Updates Distribution
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan, Jason, Jeff, Olaf, Brad, etc


Here is an idea for a cross-distribution single cd product sold/shipped
by all ppc distributions:

What we really need is a single updates CD to help bring recently
shipped distributions up to date with the latest versions of things:

Included on the disk would be:

1. openmotif with ppc patches and jdk motif bug fixes included + source

2. Jack Howarth's latest XFree 4.0 rpms + source

3. Xpmac latest with some recent updates from Ryuichi + source

4. Mozilla Milestone 16 (or the latest from the cvs tree) + source

5. Gnome Helix 1.2 rpms  + source

6. KDE 2.0 Beta 2 rpms + source

7. Franz's latest gcc 2.93 rpms + source

8. Franz's latest binutils rpms + source

9. All of the security updates since the last release of each
distribution + source

10. 2.2.16 kernel to fix latest kernel security issue + source

11. Binaries of JDK 1.1.8 final, JDK 1.2.2 final, jdk 1.3_beta  + SCSL
diffs

12. The latest Mac-On-Linux which will actually work under Mac OS 9.0.4

Plus possibly a selection of contributed RPMs + source (like R (the
stats package), Jack's molecule viewer, etc).

My idea is that the iso-image (identical) would be available from all
distributions and also sold for some small fee by all distributions.

I can create all of the JDK binaries, I am building the kde2 beta 2
stuff as I write this, I have all the GNOME Helix 1.2 binaries and
srpms, Jack has the XFree 4.0 rpms and srpms with the latest G4/Rage 128
Pro fixes in place, I have the Xpmac source (and some changes from
Ryuichi to integrate), I have access to alot of patches (both from
Blackdown and Sun) that fix serious bugs in OpenMotif 2.1, Franz already
has posted his latest tool chain, and Paul's 2.2.16 rsync kernel is
available right now.  I also have the cvs from last night of Mozilla and
will build it this week.

All of this would be available for some sort of joint effort to quickly
get out an updates CD for everyone to use.

What do people think?  Is this stealing too much thunder from thenext
distributions releases?  If not, I say let's do it.

Comments welcome!

Kevin





--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
