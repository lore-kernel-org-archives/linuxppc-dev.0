Message-Id: <4.2.0.58.19991001150704.03c6b230@mail.lauterbach.com>
Date: Fri, 01 Oct 1999 15:26:45 +0200
To: Lou Langholtz <ldl@chpc.utah.edu>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
Cc: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37F26FE5.98B8B00@chpc.utah.edu>
References: <Pine.LNX.3.96LJ1.1b7.990929021435.16135B-100000@ofey.inetnebr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 22:00 29.09.99 , Lou Langholtz wrote:
>I just locked up my system and had to reboot. The above change then 
>doesn't seem
>to fix the system hangs. On the other hand I never did see the "FB. overflow"
>message at least.

Hmm, in the recent kernels Paul changed the code to only print the FB 
message once! For me these lockups (I'm using vger nearly unmodified) are 
gone since quite a while, but I don't really know a reason why. The major 
specialties on my 7200/75 are:

- disabled syslog's fsync'ing of /var/log/messages (this prevents the 
amplifying effect of the FB messages)
- all major stuff is compiled with gcc-2.95.2pre

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
