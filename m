Message-ID: <3F33BC10.8060407@imc-berlin.de>
Date: Fri, 08 Aug 2003 17:04:48 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Questions about ARP
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

Microsoft uses "Automatic Private IP Addressing" to grab an IP address
if a DHCP request fails.

In the section "Resolving IP Conflicts" in
http://www.winnetmag.com/Articles/Index.cfm?ArticleID=7464
it says

How does the client know the IP address it's using isn't in use by
another machine? It uses a gratuitous Address Resolution Protocol
(ARP) to resolve potential conflicts. Let’s say the first client that
boots up wants to assign itself an IP address of 169.254.10.20. It
sends out a gratuitous ARP, but no one answers, so it keeps the
address ... Next, a third client boots up and picks 169.254.10.20, the
same address the first client chose. The first client tells the third
client that it's already using that IP address, so the third client
tries a different IP address and keeps it if there's no conflict.

I can see this behaviour if I connect an embedded DOS TCP/IP device to
a Windows XP computer (using a cross-linked twisted pair) and force
the IP of the DOS device to be the same as the one that the Windows XP
computer is going to claim. Fair enough.

But when I connect my MPC8xx board with Linux it seems that Linux is
not responding to the ARP requests done by the Windows machine.
Result: Both machine end up with the same IP address.

Did I miss something?
I did not find an kernel option saying something about ARP...

Any ideas?

Could someone maybe try this as well? Please?

Thanks a million,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
