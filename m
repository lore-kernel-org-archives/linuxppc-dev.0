Message-ID: <3992EAE6.27CF4490@motorola.com>
Date: Thu, 10 Aug 2000 12:48:22 -0500
From: Jeffrey Hawkins <Jeffrey.F.Hawkins@motorola.com>
MIME-Version: 1.0
To: Franz.Sirl-kernel@lauterbach.com, linuxppc-dev@lists.linuxppc.org
Subject: PPC Versions of Glibc and GCC Status
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank,

I am currently utilizing your current versions of GCC
2.95.3-2c and GLIB2.1.3-15d for my development.  Thanks
for all the hard work....

I am experiencing a few issues with LinuxThreads, which upon
querying the GNU developers/lists, I have found the issues
may have been fixed in the 2.1.9x and 2.2-beta versions.
The required fixes are in the LinuxThreads Library, as well
as, in other Libraries.

Are you currently integrating/migrating your
2.1.3 versions with 2.1.9x or 2.2.x ?  If you are not
planning on doing this, have the changes you have made,
or the changes by other LinuxPPC Developers, both to the
GCC and GLIBs, been submitted and incorporated in the GNU
running changes ?

I am just starting the process of going through the Source
for 2.1.91 and checking the differences with the 2.1.3-15d.
I am querying you on your efforts, and others, so that I don't
waste time duplicating what has already been done.  I was
hoping to use GLIB 2.1.91 off the shelf, but I know this
will probably not be the case.

Any feedback, or tips on things to look out for (such as
Libraries/Modules you had to make extensive updates to, #ifdefs
and #defines that need to be added for PowerPC), would be
appreciated.  I will be making the Source Tarballs and RPMs
available once I have completed this task.



Jeff

--
********************************************************

Jeffrey Hawkins

Senior Staff Software Engineer
Motorola Wireless Data Solutions Engineering

Address: DEPT:  DQ525
         MS:    IL-02-1055A
         1301 East Algonquin Road
         Schaumburg, IL 60196

Phone:   (847)576-7463
FAX:     (847)576-7737

********************************************************

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
