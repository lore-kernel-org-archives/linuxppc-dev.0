Message-Id: <200007052245.AAA24265@denx.local.net>
To: "TWG - pat, mark & steve" <twg@world.std.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with HardHat/NFS root filesystems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 Jul 2000 12:27:57 EDT."
             <Pine.SGI.3.95.1000705121641.27740C-100000@world.std.com>
Date: Thu, 06 Jul 2000 00:45:48 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.SGI.3.95.1000705121641.27740C-100000@world.std.com> you wrote:
>
> Thanks, Wolfgang, for your response.  It helped somewhat.  Here's what I
> discovered:
>
> 1. I am also unable to run ash.static

Then shread libs are not your primary problem.

> 2. I forgot to mention another error message (actually, I thought it was
> trivial but it's not), I also get a "Warning: unable to open an initial
> console" error message.

OK - that's a different issue, then.


> In /etc/exports, I export the volume as /opt/hardhat.....
>
> However, when I do an "exportfs -av" the exported volume shows up as
> /usr/opt/hardhat.....
> I specified /opt/hardhat... in /etc/dhcpd.conf
>
> I think, therefore, that NFS is not allowing access to the proper
> directories, and that's why it can't find an init (or a /dev/console!)
>
> Am I on the right track?

I think so - most probably your target can't see the files it  needs.
You should be able find out by running some network analyzer (tcpdump
might be enough for the job; ethereal will make it more convenient).

The quick test is to fix your configuration and try it out :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If it went on at this rate, in several billion  years  he'd  be  rich
beyond his wildest dreams!            - Terry Pratchett, _Soul Music_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
