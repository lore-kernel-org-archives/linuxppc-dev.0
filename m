Message-ID: <37D820B5.F84B223D@wanadoo.fr>
Date: Thu, 09 Sep 1999 23:03:49 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Hugh Caley <hcaley@loomer.com>
CC: Shaw Terwilliger <sterwill@io.nu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Paul's devel branch on Lombard?
References: <37D74322.B787B9FE@loomer.com> <19990909092545.C4200@io.nu> <37D7C974.77E93281@loomer.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hugh Caley wrote:
> 
> Shaw Terwilliger wrote:
> 
> > Has anyone built kernels (either 2.2 or 2.3) with GCC 2.95?  I'd build a new
> > compiler (even just to try) if I could build the newest one.  :P
> >
> > --
> > Shaw Terwilliger (sterwill@io.nu)
> 
> I build mine with 2.95, from the fsirl directory on dev.linuxppc.org.

Here is my /proc/version:

root[432]#cat /proc/version
Linux version 2.3.16 (root@chezmoi) (gcc version 2.95.1 19990816
(release)) #63 Sun Sep 5 17:09:44 CEST 1999
root[433]#uptime
 10:57pm  up 4 days,  3:48,  5 users,  load average: 0.26, 0.14, 0.10

Kernel 2.3.16 is from cvs@openprojects, with 2 little patches to make it
compile and to recognize my ethernet card. I'll reboot in a minute to
try 2.3.17.

Compiler is a mixture of F. Sirl's patch and spec file with the
"official" 2.95.1 tar.gz file.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
