Message-ID: <3DC7F628.8070005@iram.es>
Date: Tue, 05 Nov 2002 17:47:36 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: Daniel Lao <laodx@gzjpg.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A question about the 68-pin SCSI devices
References: <200211051305359.SM00332@xuyf>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Lao wrote:
> Hello,
> My system are based on Motolora's "MVME2700 + 3-row P2 adapter + MVME761
> + 50-pin SCSI devices", the linuxppc kernel is 2.212. Now I would like
> to update my system with 68-pin SCSI devices. That is , the new system
> configuration is "MVME2700 + 5-row P2 adapter + MVME761 + 68-pin SCSI
> devices". The MOT's documents said that the SCSI controler(53C825A)
> on MVME2700 can support 68-pin devices, but I am not sure whether the
> linux kernel(2.2.12) can support them. Should anyone kindly give me some
> advice? Thank a lot!

It should work right out of the box.

But why are you still using 2.2.12, because you use my VME driver ?

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
