MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: i2c-algo-8xx ???
Date: Tue, 25 Mar 2003 11:45:10 +0100
Message-ID: <30C145E544071F4FB8B627789F7910BD32BDAB@csy-exchange1.giat.intra>
From: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steven,

(I'm new on the list, so I'll quickly present myself: I'm currently
working on a custom mpc855t board with u-boot and linux, using ELDK
as the host development platform.)

> Hi there,
>
> if I understand correctly:
>
> if one want to use i2c-algo-8xx on a MPC8xx one need to init
> the CPM, install
>   an irq handler and add an i2c bus handler.
> That all is done in i2c-rpx.c. But I think what's done there
> is pretty generic
> to MPC8xx boards using the CPM for I2C.
> (I just forced a build of this file and it works on my board.)

This is consistent with the notes on the lm_sensors site, which
has a fairly extensive set of i2c drivers.

And this is consistent with some recent experiments of mine. :)

> So shouldn't we rename the file and the entry in Config.in to
> something less
> "misleading" ?

They (partly) did so in lm_sensors.

Albert.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
