From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 5 May 2003 20:15:44 -0700
To: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Busybox of Hardhat preview 2.1 for sandpoint 74xx ?
Message-ID: <20030506031544.GA29462@rover.farnsworth.org>
References: <0B0A39652BB0D411BCCF00508B9512EC08AEBD8A@tx14exm05.ftw.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0B0A39652BB0D411BCCF00508B9512EC08AEBD8A@tx14exm05.ftw.mot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 05, 2003 at 08:31:34PM +0000, Yu Bo-BOYU1 wrote:
>
> Did anyone know if busybox of hardhat preview 2.1 for sandpoint 74xx work or
> not ?
> I got error "Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted"
> no matter
> the root is mounted on NFS or ramfs.

It's been a while since I last saw it, but this reminds me of what
happens when running the 74xx userspace on a kernel that doesn't have
altivec support enabled.

-Dale Farnsworth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
