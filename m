Message-ID: <001201c2edcb$f7822240$af85efcb@qhavm>
From: "Q-ha Park" <qhpark@jchyun.com>
To: "Rakesh Jagota" <j.rakesh@gdatech.co.in>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <aoupdd247x3zp3l.190320030853@gda-server>
Subject: Re: Tuner
Date: Wed, 19 Mar 2003 12:59:35 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> i am working on custom design settop Box project in linux based on valcun
> chip(stbx25xx) ibm ppc405 . I am using montavista linux previewkit. I want to
> include the tuner driver for sharp tuner. I didnt see any driver for sharp
> tuner. Is it available and how to select this driver in our kernel.

ouch. if you're looking for the driver in the kernel tree, there's no much luck. you probably want to contact your tuner company for the driver, and you'll have to port it to linux if there's no linux version available. you may not even have to write a linux driver unless you want to, since many tuners are controlled with I2C, and the I2C driver is provided in the kernel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
