Date: Thu, 23 Mar 2000 15:03:57 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Synchronous SCSI at 10MB/s on Lombard? (fwd)
Message-ID: <Pine.SOL.3.95.1000323150218.25787A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry for crossposting, but I didn't get any response to this on the
user list.
---------- Forwarded message ----------
Date: Tue, 21 Mar 2000 02:12:47 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-user@lists.linuxppc.org
Subject: Synchronous SCSI at 10MB/s on Lombard?

One more question...

Has anyone tried to set the rate for synchronous SCSI tranfer for the MESH
controller in the G3 series Powerbooks to 10? The kernel docs claim it does
10 MB/sec on machines where the bus is internal only:

CONFIG_SCSI_MESH_SYNC_RATE:                                                 x
  x                                                                         x
  x On Power Macintoshes (and clones) where the MESH SCSI bus adaptor       x
  x drives a bus which is entirely internal to the machine (such as the     x
  x 7500, 7600, 8500, etc.), the MESH is capable of synchronous             x
  x operation at up to 10 MB/s. On machines where the SCSI bus              x
  x controlled by the MESH can have external devices connected, it is       x
  x usually rated at 5 MB/s. 5 is a safe value here unless you know the     x
  x MESH SCSI bus is internal only; in that case you can say 10. Say 0      x
  x to disable synchronous operation.                                       x

but for an uneducated test I have set it to 10, and this seems to work so
far on my Lombard. The throughput as reported by hdparm has effectively
doubled (from 3.3 to 6.6 MB/s), so does anyone know whether this is
safe or there are any dangers implied when setting the transfer rate that
high (if it only you could call this high!) on the external bus?

Thanks for any advice,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
