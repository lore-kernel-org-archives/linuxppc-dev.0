Date: Thu, 24 Jan 2002 09:04:51 -0500
From: Kent Borg <kentborg@borg.org>
To: Mark Pilon <mpilon@midrivers.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdb / gdbserver part 2
Message-ID: <20020124090451.A22567@borg.org>
References: <3C4EEFAA.1108DF1B@midrivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C4EEFAA.1108DF1B@midrivers.com>; from mpilon@midrivers.com on Wed, Jan 23, 2002 at 10:15:22AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jan 23, 2002 at 10:15:22AM -0700, Mark Pilon wrote:
> I've made some progress but have hit a strange snag and would
> appreciate any context / suggestions you might have.

I don't know if the symptoms you describe fit, be we had a related
problem recently.

Our boot ROM was not clearing the debug hardware at boot.  The ptrace
trap handling code was then tripping over spurious bits in whatever
the status word is called.

-kb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
