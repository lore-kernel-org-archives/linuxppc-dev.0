Message-Id: <200205290312.LAA15455@smtp2.reach.net.sg>
Content-Type: text/plain;
  charset="iso-8859-1"
From: jari <jari.nguyen@serialsystem.com.sg>
Reply-To: jari.nguyen@serialsystem.com.sg
To: "navinb" <ppc4@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Slave mode of usb..?
Date: Wed, 29 May 2002 10:15:04 +0700
References: <20020528123146.26155.qmail@webmail13.rediffmail.com>
In-Reply-To: <20020528123146.26155.qmail@webmail13.rediffmail.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

For slave mode, you'll need a slave controller specific layer.
It is the same as your number 3, but change them to wait
and response requests.

Read about  Enumeration process.

Regards,
Jari Nguyen Trung Thanh

On Tuesday 28 May 2002 19:31, navinb wrote:
> Hello,
>
> just one quick question regarding mpc 823/850 USB controller.
>
> as we need a
> 1.USB device driver +
> 2.USB generic stack +
> 3.host controller specific layer for host mode initialisation ..
> what all we need just for slave mode...?
>
> i think it is just host controller specific layer, am I right?
>
> Best Regards,
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
