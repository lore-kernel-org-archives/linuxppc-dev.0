Date: Fri, 3 Mar 2000 14:41:10 -0800
From: Greg KH <greg@kroah.com>
To: Brad Parker <brad@parker.boston.ma.us>
Cc: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org,
        linux-usb@suse.com
Subject: Re: [linux-usb] Re: USB Device Driver Development Resources
Message-ID: <20000303144110.E21458@kroah.com>
References: <20000303180757.9695.qmail@web1704.mail.yahoo.com> <200003032108.QAA25344@p2.parker.boston.ma.us> <20000303143347.D21458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000303143347.D21458@kroah.com>; from greg@kroah.com on Fri, Mar 03, 2000 at 02:33:47PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 03, 2000 at 02:33:47PM -0800, Greg KH wrote:
>
> But there is a person working on a Linux driver for this device without
> the help of Keyspan. His name is Brian Warner, and hopefully there will
> be some code for you to play with soon (right Brian? :)
>
> He is writing his own AnchorChip code for the device and the driver will
> download it to the converter, eliminating the need to reverse engineer
> Keyspan's vendor specific protocol. A very cool hack.
>

Oops, I forgot, there is another developer that IS working with Keyspan
to provide a Linux driver, Hugh Blemings. In fact, Keyspan has commented
to him that there have been a number of inquiries about Linux drivers
for their devices, so they have been helping him out in getting the
proper specs and firmware.

So hopefully we will have a number of Keyspan drivers to choose from
soon.

greg k-h
greg@kroah.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
