Date: Fri, 5 Feb 1999 16:45:43 +0100
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        linux-pmac@samba.anu.edu.au
From: BenH <bh40@calva.net>
Subject: BootX test 1.0.2b1
Message-Id: <19990205164543.000681@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At this address:

<ftp://ftp.linuxppc.org/development/users/benh/BootX_1.0.2b1.sit>

Is a test version of BootX. It contains some minor changes that I want to
be tested before it becomes 1.0.2 final. Please tell me if it breaks
something on your config that used to work with 1.0.1. Please also tell
me if there is a difference in behaviour with 1.0.1.

Changes:

 - MacOS video drivers are closed before switching to linux
 - Supports Finder aliases for the kernel and ramdisk
 - Slight changes to the infos passed to the kernel, will do no harm for
now and will improve compatibility once the appropriate kernel patch is
released.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
