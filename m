Date: Wed, 1 Mar 2000 12:28:00 -0800 (PST)
From: Bill Brooks <wbrooks@lug.ee.calpoly.edu>
To: Info <info@amberjack.net>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC vs. RedHat???
In-Reply-To: <Pine.LNX.3.96.1000301091552.2277C-100000@deepspace.mklinux.org>
Message-ID: <Pine.LNX.4.10.10003011201020.13583-100000@lug.calpoly.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 1 Mar 2000, David A. Gatwood wrote:

> > -Other than recompiling on wintel for delivery, can anyone see
> > potential problems with using LinuxPPC in a RedHat shop?
> > -Any known problems with JAVA tools (JDK, JSDK, Tomcat)?
>
> You mean taking LinuxPPC and trying to rebuild it on x86?  Good luck.  The
> words source compatible tend to be somewhat exaggerated when it comes to
> real-world use, especially where RPMs are involved.  Just MHO.

Reading the last bullet point, I think the poster was asking about
developing something in Java.

I personally have been using the Blackdown JDK 1.2.x tools on LinuxPPC
since they were released and have never had a problem moving Java source
OR binaries between JDK 1.2/Blackdown/LinuxPPC and JDK
1.2/Blackdown/RedHat5.2 - 6.1. I've been using Tomcat and Sun JSDK 2.0
since the first milestone drop and haven't ever had a problem that's not
reproducible on RedHat for x86. As far as I can tell, they are bug
compatible :-)

You'll have a harder time finding .rpm's for Tomcat, etc for PPC, but
that's not going to really stop you from doing Java development on
LinuxPPC in a RedHat shop at all.

Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
