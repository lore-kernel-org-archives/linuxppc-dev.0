Date: Mon, 5 May 2003 21:11:54 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: Yu Bo-BOYU1 <Bo.Yu@motorola.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Busybox of Hardhat preview 2.1 for sandpoint 74xx ?
Message-ID: <20030505211154.A12082@home.com>
References: <0B0A39652BB0D411BCCF00508B9512EC08AEBD8A@tx14exm05.ftw.mot.com> <20030506031544.GA29462@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030506031544.GA29462@rover.farnsworth.org>; from dale@farnsworth.org on Mon, May 05, 2003 at 08:15:44PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 05, 2003 at 08:15:44PM -0700, Dale Farnsworth wrote:
>
> On Mon, May 05, 2003 at 08:31:34PM +0000, Yu Bo-BOYU1 wrote:
> >
> > Did anyone know if busybox of hardhat preview 2.1 for sandpoint 74xx work or
> > not ?
> > I got error "Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted"
> > no matter
> > the root is mounted on NFS or ramfs.
>
> It's been a while since I last saw it, but this reminds me of what
> happens when running the 74xx userspace on a kernel that doesn't have
> altivec support enabled.

Just to confirm, with the MSR VEC off on a 74xx core, it will definitely
generate that bad trap (UnknownException) on mvista 74xx userspace.  I've
seen it on 7xx's that were unintentionally run on the ppc_74xx userspace,
for example.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
