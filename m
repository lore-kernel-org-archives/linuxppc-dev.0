Message-Id: <199910121252.HAA17852@lists.linuxppc.org>
Date: Tue, 12 Oct 1999 08:50:05 -0400 (EDT)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: Argo UML and LinuxPPC
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        geiseri@msoe.edu
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>	I have gotten to the point where it fails ONLY
>	because it cannot find my swing classes.

The swing classes are part of the jdk 1.2.1 distribution.  If you are getting a 
"can't find metal look and feel" type error then the fault is in your X frame 
buffer server and not in the JDK.  Check out Tom Rini's latest X rpm for that 
fix and many many others.

If you are using jdk 118, then you must grab the swing classes from Sun of my 
server http://khendricks.ivey.uwo.ca and install them and add them to your 
classpath properly.

Please try that, and if you still run into problems, please send the "exact" 
error message to me and I will try to help.

I hope this does the trick,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
