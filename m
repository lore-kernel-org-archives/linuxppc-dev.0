Date: Fri, 5 Oct 2001 19:43:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Ricardo Scop <scop@digitel.com.br>,
	Andrew Johnson <anj@aps.anl.gov>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS?
Message-ID: <20011005194357.C7938@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011003130559.F31866@borg.org> <20011005111145.C8157@borg.org> <3BBDD64F.97B0057B@aps.anl.gov> <01100519044401.01029@scop.digitel.com.br> <3BBE6B92.60497E1@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BBE6B92.60497E1@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 05, 2001 at 10:25:22PM -0400, Dan Malek wrote:
>
> Ricardo Scop wrote:
>
> > We internally use CVS nowadays, therefore I'm very interested in your
> > standard procedures to manage externally developed code.
>
> I would appreciate a patch against the current linuxppc_2_4_devel
> tree.  Please pull the latest tree, do your work in that tree, and
> then generate a patch using one of the convenient bk commands that
> I hope Tom Rini can suggest :-).

For uncommited (and this _won't_ catch new files):
bk -r diffs -u > foo
Or, if you commit everything and just want that rev:
bk export -tpatch -rRev (bk changes will show).
For multiple revs get the rev # of the latest pull of the external
source to yours.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
