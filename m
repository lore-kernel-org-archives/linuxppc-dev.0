Message-ID: <3D6E4A4A0000123A@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com)
Content-Type: text/plain;
  charset="iso-8859-1"
From: jim <jduey@ccc-dcs.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Delay on starting init
Date: Thu, 12 Sep 2002 10:27:01 +0000
References: <20020911175118.04A9E38E9D@server.weathercom.com> <20020912012457.GX13670@zax>
In-Reply-To: <20020912012457.GX13670@zax>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, that's three datapoints.  I'm also using an NFS root.  I tracked it as
far as the sys_execve call that's in arch/ppc/kernel/process.c.  It seems to
execute that function fast enough.  I got hung up trying to determine exactly
what was going on in include/asm-ppc/unistd.h with the _syscall3 macro.
Those two files are where I'd start looking.

If anyone finds the cause of the delay on starting init with NFS root file
systems, please post to the list.

Jim

On Thursday 12 September 2002 01:24 am, David Gibson wrote:
>
> I've observed this as well, but I haven't tracked it down much.  When
> I looked into it the delay seemed to be due to NFS delays and timeouts
> (I'm using an NFS root), but that doesn't explain why it is so much
> worse in recent 2.4 and (especially) 2.5.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
