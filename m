From: Benjamin Herrenschmidt <bh40@calva.net>
To: <daenzerm@student.ethz.ch>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sound again [was: Re: xf4 bug report]
Date: Wed, 26 Jul 2000 13:09:23 +0200
Message-Id: <20000726110923.9381@mailhost.mipsys.com>
In-Reply-To: <397EB684.592827BD@relog.ch>
References: <397EB684.592827BD@relog.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Just wanted to tell that after putting earphones to the Mac, the sound
>> comes. Appearently it is only the internal speaker which does not work.
>
>Just for the record:
>
>My Pismo shows the same behaviour, the 'compatible' file in /proc/device-tree
>says 'screamerawacs'.

I'm not completely sure, but some of these machines have the sound output
routed to an external I2C "SRS"/ampilfier module that drives the
speakers. We have code to set it up via Cuda on older machines, but not
for newer Core99 machines.

An interesting note also: When using this external module, Darwin driver
"fix" the AWACS volume to a constant value and uses the amplifier volume
control via I2C.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
