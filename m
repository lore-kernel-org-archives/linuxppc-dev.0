From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15419.31427.603521.763333@argo.ozlabs.ibm.com>
Date: Wed, 9 Jan 2002 10:03:31 +1100 (EST)
To: mod+linuxppc-dev@MissionCriticalLinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Link-time failures from "simple" CFLAGS changes 
In-Reply-To: <200201072328.SAA07991@missioncriticallinux.com>
References: <20020107230001.GB13931@cpe-24-221-152-185.az.sprintbbd.net>
	<200201072328.SAA07991@missioncriticallinux.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


mod+linuxppc-dev@MissionCriticalLinux.com writes:

> >> Sheesh!    Well, OK then: please apply this patch:
> >
> >Feel free to pass it onto Marcelo and/or Linus.
>
> I can wait - it'll eventually make it into the main
> branch when the linuxppc work gets merged, right?

Tom, Ben and I will send off stuff in arch/ppc, include/asm-ppc, and
some of the PPC-specific drivers to Marcelo or Linus.  For other
stuff, like this documentation change, the people who want the change
need to send the patch to Marcelo, Linus, or the appropriate driver or
subsystem maintainer.

In particular, the top-level Makefile in linuxppc_2_4_devel has an
extra line in the TAGS target.  I'm not going to send this in; someone
who wants this change to go in should take on the job of submitting it
to Marcelo (or Linus) and the linux-kernel mailing list.  It may take
multiple attempts. :)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
