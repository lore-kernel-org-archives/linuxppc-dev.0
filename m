Date: Wed, 10 Jan 2001 17:43:18 +0100
Subject: Kernel 2.4.0 and Netatalk
From: Chris Boot <bootc@worldnet.fr>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B6824E71.8287%bootc@worldnet.fr>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

After I upgraded to kernel 2.4.0 (bk linuxppc_2_4), I found that netatalk
could not access my Zip drive.  This worked in the 2.2 series kernels.  If I
add my zip drive's mount point to my .AppleVolumes file, when the zip is not
mounted, all works fine, but if a zip disk is mounted and I try to log in,
when I try to mount a volume, my computer complains that it lost the
connection.

If I look in /var/log/messages, all I see is messages like this:
Jan 10 18:29:05 tequila afpd[594]: login bootc (uid 500, gid 500)
Jan 10 18:29:05 tequila afpd[568]: server_child[1] 594 killed

The volume appears in the volume list.

I originally thought that this may be due to an incompatibility with autofs,
which I had been using, but even if I disable it, the messages are exactly
the same.  I'm mounting with mount options "fork=netatalk,uid=500,gid=500".

Is there any way I can make this work?  Would upgrading to the latest
development release of netatalk help?

Thanks for any information,

--
    .-.        Chris Boot
    /v\     bootc@worldnet.fr
   // \\
  /(   )\   L   I   N   U   X
   ^^-^^   >Phear the Penguin<

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
