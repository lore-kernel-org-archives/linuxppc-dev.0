In-Reply-To: <199903242312.KAA31937@tango.anu.edu.au>
Date: Thu, 25 Mar 1999 13:10:50 +0100
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Blue G3 and machine check
Message-Id: <19990325131050.003668@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 25, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>Did the original poster say whether the machine checks were on config
>space accesses or I/O or memory space accesses?  It's common enough
>for drivers written for intel linux to go probing I/O ports to try to
>find devices to talk to.

The original poster wrote that the machine check happens when reading
config space on a non-existent device thru the PCI<->PCI bridge. The
proposed fix was simply to add two globals "machine_check_expected" and
"machine_check_received". The first one set to true before the probe, and
the machine check exception handler incrementing the second one when the
first one is true.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
