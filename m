Message-ID: <19991017173229.A9773@elmo.cygnus.com>
Date: Sun, 17 Oct 1999 17:32:29 -0400
From: Michael Meissner <meissner@cygnus.com>
To: David Edelsohn <dje@watson.ibm.com>,
        ian reinhart geiser <geiseri@msoe.edu>
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: OLD gcc source needed...
References: <geiseri@msoe.edu> <9910171727.AA10306@marc.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9910171727.AA10306@marc.watson.ibm.com>; from David Edelsohn on Sun, Oct 17, 1999 at 01:27:32PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 17, 1999 at 01:27:32PM -0400, David Edelsohn wrote:
> 
> 	gcc-2.6.3 did not support Linux/PPC.  It may not have supported
> SVR4/ELF PowerPC ABI used by Linux/PPC at all.

As I recall, there were patches floating around in the LinuxPPC group adding
support.  True they weren't in the FSF repository, but they were available as
part of the initial LinuxPPC that Gary put out.  Of course the changes for SVR4
to LinuxPPC are fairly minimal (change crt files and -D macros if I recall).

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
