Message-ID: <38AA2785.DC12EA82@execpc.com>
Date: Tue, 15 Feb 2000 22:28:53 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC, g++ problem with throw/catch (fwd)
References: <Pine.LNX.3.96L.1000215114646.6511B-100000@nitfol.weh.andrew.cmu.edu>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard wrote:
>
> ---------- Forwarded message ----------
> Date: Tue, 15 Feb 2000 09:58:52 -0500
> From: Pierre Sarrazin <sarrazip@machinasapiens.com>
> To: linuxppc-user@lists.linuxppc.org
> Subject: LinuxPPC, g++ problem with throw/catch
>
> I am having a strange problem with LinuxPPC and g++ and I would like
> to have a confirmation that it is not specific to my machine. A C++
> exception is thrown and should be caught but is not.

using gcc version 2.95.1 19990809 (prerelease), i got the same results.  Once i
turned on optimization, it worked correctly.  I tried -O0 (same bad results),
but -O1 and -O6 work fine.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
