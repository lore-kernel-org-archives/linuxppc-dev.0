Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh Jagota <j.rakesh@gdatech.co.in>
To: "Q-ha Park" <qhpark@jchyun.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Tuner
Date: Wed, 19 Mar 2003 11:00:05 +0530
References: <aoupdd247x3zp3l.190320030853@gda-server> <001201c2edcb$f7822240$af85efcb@qhavm>
In-Reply-To: <001201c2edcb$f7822240$af85efcb@qhavm>
MIME-Version: 1.0
Message-ID: <mv1lfaynz2zisom.190320031708@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Thankx for info. I have seen some of the tuner driver in
../linux/drivers/media/video folder. But i didnt find any driver for sharp
tuner there. One more confusion is there, How can we select the tuner card in
the config file for particular card, and is there anything else we have to
write for tuner card to get it work. I have seen i2c driver is also there.
Can you tell me exactly how we have to configure it.

Thanks in advance,

Rakesh

On Wednesday 19 March 2003 09:29 am, Q-ha Park wrote:
> > i am working on custom design settop Box project in linux based on
> > valcun chip(stbx25xx) ibm ppc405 . I am using montavista linux
> > previewkit. I want to include the tuner driver for sharp tuner. I didnt
> > see any driver for sharp tuner. Is it available and how to select this
> > driver in our kernel.
>
>
> ouch. if you're looking for the driver in the kernel tree, there's no much
> luck. you probably want to contact your tuner company for the driver, and
> you'll have to port it to linux if there's no linux version available. you
> may not even have to write a linux driver unless you want to, since many
> tuners are controlled with I2C, and the I2C driver is provided in the
> kernel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
