Mime-Version: 1.0
Message-Id: <v04210104b4286832a354@[206.173.237.233]>
In-Reply-To: 
 <Pine.LNX.4.10.9910112307420.26305-100000@sleepchamber.apt5.msoe.edu>
References: 
 <Pine.LNX.4.10.9910112307420.26305-100000@sleepchamber.apt5.msoe.edu>
Date: Mon, 11 Oct 1999 22:02:16 -0700
To: ian reinhart geiser <geiseri@msoe.edu>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
From: Randall R Schulz <rrschulz@cris.com>
Subject: Re: Argo UML and LinuxPPC
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ian,

I just downloaded this program myself and haven't yet worked with it. 
However, here are a few relevant facts:

- There are two current versions of Argo/UML available: 0.5.2 and 
0.7. 0.5.2 is a stable production release, 0.7 is still beta / 
pre-release.

- Version 0.5.2 requires you have JDK 1.1.x (x >= 7; JDK 1.2.x is not 
supported) and the separately installed Swing. Note, too, that you 
*must* use Swing 1.0.3 and *must not* use Swing 1.1.1. Swing 1.1.1, 
though basically an upwardly compatible upgrade in concept, cannot be 
freely substituted into Java programs written for 1.0.3 because the 
names of the packages in which the Swing classes reside was changed.

- I note that when I retrieved all the LinuxPPC Java files (both 
1.1.8 and 1.2.1) that the JDK 1.1.8 files included Swing 1.1.1 only. 
I don't believe there's anything special about Swing itself (Swing, 
per se, is 100% Pure Java, so you should be able to just go to Sun's 
JFC site and download JFC 1.1 / Swing 1.0.3 (see 
<http://java.sun.com/products/jfc/index.html>. To download this 
version, visit <http://java.sun.com/products/jfc/download-103.html>) 
and use its swingall.jar file in your CLASSPATH when running Argo/UML.

- Version 0.7 works with either JDK 1.1.x (x >= 7) or JDK 1.2.x. 
Since JDK 1.2 / JRE 1.2 include Swing, it need not be separately 
installed. If you're using JDK 1.1.x, you still need Swing 1.0.3 and 
all the previous caveats for Argo/UML v0.5.2 still apply.

As I said, I haven't worked with this software yet, so what I'm 
telling you is based on what's indicated on the Argo/UML site and my 
own knowledge of Java and Swing, such as it is. When I've had a 
chance to give some of this a try, I'll pass on any further pointers 
I come up with.

Good luck.

Randy Schulz
Mountain View, CA USA


At 23:12 -0500 10/11/99, ian reinhart geiser wrote:
>	... I have faught with ArgoUML a Java based UML
>	package now ever since Java for R5 has been out.
>
>	I have gotten to the point where it fails ONLY
>	because it cannot find my swing classes.
>
>	...
>
>	ideas?
>
>	thanks in advance.
>
>	-ian reinhart geiser

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
