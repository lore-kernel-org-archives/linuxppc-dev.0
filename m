Message-ID: <3809FB72.43C36176@tiac.net>
Date: Sun, 17 Oct 1999 12:38:13 -0400
From: Patrick Callahan <pac1@tiac.net>
MIME-Version: 1.0
To: "yellowdog-general@lists.yellowdoglinux.com"
 <yellowdog-general@lists.yellowdoglinux.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: How does it all fit together?
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Where can I read and research about how the video settings and the
software that uses the settings  fit together in the context of he MAC
OS, BootX, Linux Boot, Linux Console and X Window processes on PPC
hardware.

The relevant settings are:

    MacOS Monitor Settings

    BootX
        no video driver option checked/unchecked
        several kernel arguments related to video

    XConfig values for monitor settings.

Various video drivers.

At the moment, I can make Linux and X work by choosing values that are
known to work on my hardware.  Using values for bootX kernel arguments
suggested by others in various mail messages also frequently works.

I'd like to go beyond this and find or write documentation on these
items as a group, explaining how they work together with specific pieces
of software to determine the final outcome you see on your monitor.  I'd
like to pull together information that will illuminate how things
actually work together, in addition to documenting sets of values that
actually work on various machines.

If there is  any information like this out there, I've been unable to
find it so far.  If you know of any, can you point me in the right
direction?

If there is no existing documentation along these lines, is anyone
interested in working on such a project?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
