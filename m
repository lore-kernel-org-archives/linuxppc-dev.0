From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: olefilter in latest Applixware 4.42 just hangs so no Office import
Date: Sat, 9 Oct 1999 09:45:43 -0400
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99100909503100.25085@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just finished installing my upgrade to R5 version of Applixware (4.42).

The only problem is that the new olefilter (the old one was written in java)
just simply hangs when doing an improt of any Office documents.

This was the whole reason I wanted Applix to begin with (and it worked under R4
for 4.41).

The funny thing is, if I ran "fix" on all of the old R4 applix code and replace
the jre116 with the latest R5 jre118, everything works as advertised.

Has anyone else gotten the latest Applixware olefilter to work?

Does anyone know (which developer) I should forward this report to at Applix to
get it fixed?

By the way if this matters, this is with 2.2.12, glibc 2.1.2 etc.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
