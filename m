Date: Mon, 24 Mar 2003 09:09:52 -0800
From: Till Straumann <strauman@slac.stanford.edu>
Subject: Re: dcbz works on 862 everywhere!
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3E7F3BE0.7020300@slac.stanford.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <IGEFJKJNHJDCBKALBJLLCEGFFLAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>>>Hi list
>>>
-- snip --

>>>  I even
>>>removed the TLB change bit hack by Tom Rini and everything works.
>>>
-- snip --

>
>I removed the "copy DAR to MD_EPN" part in the DTLB Error handler and my systems
>runs fine.
>

How exactly do you know that "everything works fine" ???

Please note that

    a) you may have bug-free hardware.
    b) you may have a valid TLB entry at the time 'dcbz' is executed.
    c) you may end up with a bogus mapping but not notice it.

You really should first confirm that your hardware suffers from the bug by
running a _simple_ test program in a _simple_ environment (NOT linux).

Then, you should confirm that your workaround solution is correct by
testing it in the same simple environment.

Just because you are able to use 'dcbz' on linux repeatedly without
crashing does'nt prove that your hardware is buggy but linux handles
it correctly.

-- Till

PS: please CC me on any replies; I'm not subscribed to this list

>
>   Jocke
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
