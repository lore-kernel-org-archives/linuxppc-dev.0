Subject: Re: Jffs2 i386 binary for powerpc
From: Gary Thomas <gary@mlbassoc.com>
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <012701c3d0f5$a2777ad0$9104050a@JACKYLAM>
References: <012701c3d0f5$a2777ad0$9104050a@JACKYLAM>
Content-Type: text/plain
Message-Id: <1073046687.2305.67.camel@hermes>
Mime-Version: 1.0
Date: 02 Jan 2004 05:31:28 -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-01-01 at 22:59, Jacky Lam wrote:
> Hi,
>
>     I have subscribed Montavista. But I find that it doesn't contain
> mkfs.jffs2 for me to create a JFFS2 filesystem image on i386 host. (It
> contains a ppc binary version and it works.) I have tried to download it
> from JFFS2 official homepage. But the image created cannot be mounted. Could
> anyone help? Thanks.

Be sure that the image you create on your i386 (PC) machine is built
in Big Endian mode which the PowerPC uses.  Also, the erase block size
must match for things to work well.

A typical command to create the JFFS2 image might be:
  # mkfs.jffs2 -b -e 0x40000 -o JFFS2.img -r JFFS2.root
where "JFFS2.root" is the directory which contains the file system to
be copied into the JFFS2 image "JFFS2.img".

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
