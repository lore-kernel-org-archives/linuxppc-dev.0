Date: Sun, 31 Jan 1999 22:35:53 -0500
From: Beecher Greenman <rbg6038@ritvax.isc.rit.edu>
Subject: EGCS upgrade?
To: linuxppc-dev@lists.linuxppc.org
Message-id: <01J77GMEJG9Q9JDPMS@ritvax.isc.rit.edu>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried upgrading to EGCS 1.0.3 using the RPM on biggi.linuxppc.org. It 
didn't work, so I tried uninstalling it and reinstalling with the 
original RPM's, but that appears to have fried my libstdc++, which among 
other things keeps Netscape from working. I'm trying to upgrade EGCS as 
high as I can, since I want to try running Kernel 2.2.1 (anyone have a 
prebuilt kernel out there, by any chance?)

Compiiling from the Cygnus sources for 1.1.1 didn't seem to work; there 
were more than a few errors when I tried (and that's really a shame; I 
was reading that 750 support was just added and I wanted to try that one 
out).

Anyway, what's the best way to upgrade my EGCS installation past the 1.0 
on biggi? For that matter, where can I find another copy of libstdc++; I 
didn't see any RPM's on biggi that might have it. Thanks!

-Beecher Greenman

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
