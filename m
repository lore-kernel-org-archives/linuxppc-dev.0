Message-ID: <3F33EADE.4010908@embeddededge.com>
Date: Fri, 08 Aug 2003 14:24:30 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Questions about ARP
References: <3F33BC10.8060407@imc-berlin.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> But when I connect my MPC8xx board with Linux it seems that Linux is
> not responding to the ARP requests done by the Windows machine.
> Result: Both machine end up with the same IP address.

Fortunately, Linux isn't Windows......you are going to find lots of
Windows "standard" protocols that aren't documented nor supported by
anyone else.

> Did I miss something?

Well, Microsoft did.....there is RFC2131 that describes how you are
supposed to use an ARP to respond to a duplicate IPv4 used on the
network.  It is commonly used to ensure you don't have systems
manually configured or not honoring leases when DHCP is handing out
dynamic IP addresses.  Everyone else seems to implement this properly.

> I did not find an kernel option saying something about ARP...

That's because it implements the standard protocols by default.

> Any ideas?

Run DHCP or properly manually configure your Linux system.  I don't
know how old your Linux kernel is for the 8xx, but this support for
RFC2131 has been in Linux for a very long time.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
