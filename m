Message-ID: <3A8D627C.C1C8F53@wanadoo.fr>
Date: Fri, 16 Feb 2001 18:25:16 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Mats Soderstrom <mats@ibk.liu.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Repost: Cannot remove directory `xpti.dat': Operation not permitted
References: <3A8ADFD7.AB3E73B1@ibk.liu.se> <20010214183504.A3488@lsil.com> <3A8CFB2D.310B76CE@ibk.liu.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mats Soderstrom wrote:
>
> I posted this earlier asking for help. After a system crash I had to run fsck
> manually on several volumes - for me this is saying "yes" to whatever fsck ask if
> it should fix. Anyway, after a restart the properties of xpti.dat (a mozilla
> component) is changed and I cannot remove it as root. So how do I go about fixing
> this?

This might be a case for debugfs from e2fsprogs. You can unlink any file with this, but you can also screw up your filesystem. Make sure you use the latest version (>=
1.19) and read the man page.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
