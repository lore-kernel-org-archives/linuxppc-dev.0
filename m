Date: Wed, 28 Jun 2000 10:11:25 -0500 (CDT)
From: Grant Erickson <erick205@tc.umn.edu>
To: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A question about head.S
In-Reply-To: <3909A05A.E1901D52@cern.ch>
Message-Id: <Pine.SOL.4.20.0006281010510.21415-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>From 'info as':

Local Symbol Names
------------------

   Local symbols help compilers and programmers use names temporarily.
There are ten local symbol names, which are re-used throughout the
program.  You may refer to them using the names `0' `1' ... `9'.  To
define a local symbol, write a label of the form `N:' (where N
represents any digit).  To refer to the most recent previous definition
of that symbol write `Nb', using the same digit as when you defined the
label.  To refer to the next definition of a local label, write
`Nf'--where N gives you a choice of 10 forward references.  The `b'
stands for "backwards" and the `f' stands for "forwards".


--
 Grant M. Erickson                    University of Minnesota Alumni
  o mail:erick205@tc.umn.edu                              1996 BSEE
  o http://www.tc.umn.edu/~erick205/                      1998 MSEE

On Fri, 28 Apr 2000, Pei-Jie Hong wrote:
> In arch/ppc/kernel/head.S, there are lines looks like
> bne 4f or b 5f, I know they are branch instructions, but what
> about 4f or 5f. Are they the relative length? and what is the unit,
> I mean if 4f is a number , is it number of instructions or number
> of bytes or words?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
