Message-Id: <4.3.2.20000628111453.00b44440@falcon.si.com>
Date: Wed, 28 Jun 2000 11:17:03 -0400
To: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>, linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: A question about head.S
In-Reply-To: <3909A05A.E1901D52@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can use numbers for local (temporary) labels followed by 'f' for
forward or 'b' for back.  The instruction bne 4f goes to the label '4'
further down in the program.  If it was bne 4b, it would go to the
label '4' previously seen in the file.  This is good for short logical
jumps and loops.  Use the feature with care, massive confusion
otherwise ensues.

gvb


At 04:29 PM 4/28/00 +0200, Pei-Jie Hong wrote:

>In arch/ppc/kernel/head.S, there are lines looks like
>bne 4f or b 5f, I know they are branch instructions, but what
>about 4f or 5f. Are they the relative length? and what is the unit,
>I mean if 4f is a number , is it number of instructions or number
>of bytes or words?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
