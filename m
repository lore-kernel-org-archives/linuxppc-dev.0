Content-Type: text/plain;
  charset="iso-8859-1"
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Magnus Damm <damm@opensource.se>
Subject: Re: Runtime Altivec detection
Date: Fri, 7 Mar 2003 12:18:22 -0600
Cc: linuxppc-dev@lists.linuxppc.org
References: <20030307164753.GA5240@ruralcenter.org> <1047058865.12206.44.camel@zion.wanadoo.fr> <20030307185552.0da9897b.damm@opensource.se>
In-Reply-To: <20030307185552.0da9897b.damm@opensource.se>
MIME-Version: 1.0
Message-Id: <200303071218.22716.hollis@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday 07 March 2003 12:55 pm, Magnus Damm wrote:
> > There's a much better way. The kernel passes down CPU features
> > bits down to userland via ELF AUX tables.
>
> Any pointers where I can find information about that?

I played with this once, though I don't remember the outcome (it was a long
time ago). The ELF AUX table is passed as another argument to main(). I think
there may have been another one in between:
	int main(int argc, char *argv[], int something, struct elf_aux_table *table);
Then you can parse table as you like.

This was from information in the SysVR4 ABI PPC addendum, a link to which can
be found at http://penguinppc.org/dev/library/ .

-Hollis
--
IBM Linux Technology Center

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
