Message-ID: <3916B3AD.8496DCC8@ccrl.mot.com>
Date: Mon, 08 May 2000 07:31:41 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Jerry Nguyen <jerry_nguyen_75@yahoo.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MPC821
References: <20000508041028.24425.qmail@web4604.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Its rather trivial to put an ide device - i.e. a harddisk -
directly on the external bus of the MPC8xx - with maybe
some buffering and address decode to select between
IDE's two chip selects - or if you can afford it, just use
two of the 8xx's chip selects.

Steve

Jerry Nguyen wrote:

> Hi
>
> Sorry for the off-topic posting but I am stuck to this
> mail list. I am doing my thesis for my Master
> degree,which I want to build a IDE controller to work
> with MPC821. Can anyone tell me how difficult it is?
> or give advice where can I find related material, any
> example would be great. sorry for my humble english.
>
> Thanks in advance
> Jerry
>

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
