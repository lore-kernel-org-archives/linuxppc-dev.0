Message-ID: <38DA5D9F.53A48659@execpc.com>
Date: Thu, 23 Mar 2000 12:08:31 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Synchronous SCSI at 10MB/s on Lombard? (fwd)
References: <Pine.SOL.3.95.1000323150218.25787A-100000@juliet>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derek Homeier wrote:
> Has anyone tried to set the rate for synchronous SCSI tranfer for the MESH
> controller in the G3 series Powerbooks to 10? The kernel docs claim it does
> 10 MB/sec on machines where the bus is internal only:

I have tried it on my PDQ/300.  My SyQuest worked fine, but according to /proc,
it was still running at 5.  however, my yamaha cdrw did not work.  set 5, it
reports its sync speed is 4.2.  when MESH is told to max at 10, my RW is still
recognized, reports 8.4, but does not respond to mounting, reading, nor
writing.  It could be that the 6.6 you have achieved is still doable, but my 8.4
is not. so setting MESH to 7 or 8 may be a safer fast speed.  havent tried it
though.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
