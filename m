Message-ID: <387E7D52.41DA6E45@wvi.com>
Date: Thu, 13 Jan 2000 17:35:15 -0800
From: Jim Potter <jrp@wvi.com>
Reply-To: jrp@wvi.com
MIME-Version: 1.0
To: Greg Allen <gallen@arlut.utexas.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CodeWarrior objects -> LinuxPPC
References: <v04011700b4a419989df1@[129.116.196.236]>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I presume that you mean CW on MacOS.
They generate PEF files, the details of which are described on Apple's developer
site:
<http://developer.apple.com/techpubs/mac/runtimehtml/RTArch-89.html>
and there is some code (IOPEFloader.c, if memory serves) on Apples darwin site:
<http://publicsource.apple.com/projects/darwin/>
..Jim..

Greg Allen wrote:

> Is it possible compile C source in CodeWarrior and create an object (or
> library) that can be used under LinuxPPC?
>
> For example, you should be able to take a really simple program, like:
>
> #include <stdio.h>
> void goo(float f)
> { printf("goo: f = %g\n", f); }
>
> make an object in CW, copy to LinuxPPC, link it with gcc into some app that
> can call goo.
>
> (Why? CW has an AltiVec compiler, Linux currently has none.)
>
> I notice that a CW "Shared Library" is recognized by /usr/bin/file as
> "header for PowerPC PEF executable", but objdump will have nothing to do
> with it.
>
> My initial guess is "not yet".  Has anyone else ever tried this?
>
> I guess there's no reason that objcopy couldn't be extended to handle this
> (assuming CodeWarrior's object/lib file formats are public info).
>
> Thanks,
> -Greg
> --------------------------------------------------------------------
> |  Gregory E. Allen, Research Engineer  <gallen@arlut.utexas.edu>  |
> |   Advanced Technology Laboratory, Sonar Development Division     |
> | Applied Research Laboratories: The University of Texas at Austin |
> --------------------------------------------------------------------

--
Sincerely,

Jim Potter
45th Parallel Processing
503.769.9138
jrp@wvi.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
