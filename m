Date: Tue, 24 Oct 2000 15:16:44 +1100
From: Chris Leishman <masklin@debian.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: airport woes?
Message-ID: <20001024151644.A660@nina.dev.fol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Something appears to be odd with the airport under PPC.

Unfortunatly I've been stuck behind a fairly awful link recently, and have
had to open interactive connections to remote hosts.  The quality of the link
is terrible with average ping times of up to 1sec, and packet loss between 12
and 25 percent.

I've been using ssh to connect to remote hosts, and needless to say the
response time is shocking.

However, I've also had problems where the session totally locks up - I type at
the terminal as much as I like, but nothing reaches the other end.  At first I
put this down to the crappy network link.  However I've also noticed more
recently that only _half_ the connection craps out - I can still receive data
from the remote server.  Weird.

Then today I switched to use ethernet instead of the airport (I was
transfering some large files and wanted to use 100Mb), and I noticed that I
wasn't getting the lockup problems with the remote hosts.

I'm using benh's latest kernel and airport driver.  Now I can't think what
would be causing this, but I thought you'd like to know.  Anyone else seen
this problem?


Regards,

Chris


--
----------------------------------------------------------------------
       Knuth: premature optimization is the root of all evil.
----------------------------------------------------------------------
Reply with subject 'request key' for GPG public key.  KeyID 0xB4E24219

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
