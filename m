Date: Tue, 09 Jan 2001 21:21:34 +0100
Subject: /proc/sys/net/ipv4/ip_always_defrag
From: Chris Boot <bootc@worldnet.fr>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B6813150.8234%bootc@worldnet.fr>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just upgraded to kernel 2.4.0 from bitkeeper.fsmlabs.com (linuxppc_2_4)
and managed to get over all problems I had (very few) relatively easily.  I
immediately noticed the speed increase (my 5400/180 can serve files at an
amazing 6400 Kb/sec!).  Nice work!

One minor problem though, is that when I boot up (from a LinuxPPC 2000
installation), after the "Entering non-interactive startup" message, I get a
message stating that it could not find the file
"/proc/sys/net/ipv4/ip_always_defrag", which it tries to set to "1" by
echoing to it.  Can this be ignored?  Is there a way of either getting this
proc entry back or removing the script code that echoes to it?  I must admit
that I haven't looked at any of the files in /etc/rc.d with great detail...

Thanks,

--
    .-.        Chris Boot
    /v\     bootc@worldnet.fr
   // \\
  /(   )\   L   I   N   U   X
   ^^-^^   >Phear the Penguin<

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
