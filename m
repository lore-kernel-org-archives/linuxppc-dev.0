Date: Wed, 18 Oct 2000 17:24:17 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Chris Leishman <masklin@debian.org>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
In-Reply-To: <20001019021653.A383@nina.dev.fol>
Message-ID: <Pine.LNX.4.21.0010181720190.24224-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Oct 2000, Chris Leishman wrote:
> I know it sounds dumb, but have you ensured that you've got the root partition
> set correctly?  I've seen these errors before when I had a root partition
> specified that didn't contain /dev or /sbin/init.

/dev/sda5 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda2 on /boot type ext2 (rw)
/dev/sda6 on /home type ext2 (rw)
/dev/sda7 on /export/data1 type ext2 (rw)
/dev/sda8 on /export/data2 type ext2 (rw)

And I give the following argument root=/dev/sda5
with the 2.4.0 kernel it fails but with a 2.2.17 kernel it works.

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
