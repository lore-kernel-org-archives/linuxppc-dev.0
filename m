Subject: Re: common config fails to open /dev/console
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031111211016.GA9623@suse.de>
References: <20031111211016.GA9623@suse.de>
Content-Type: text/plain
Message-Id: <1068602414.13217.25.camel@gaston>
Mime-Version: 1.0
Date: Wed, 12 Nov 2003 13:00:15 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-11-12 at 08:10, Olaf Hering wrote:
> I got this oops with the attached config. it dies in init_dev() because
> driver->ttys contains NULL.
>
> sys_open -> filp_open -> dentry_open -> chrdev_open -> tty_open -> init_dev
>
> maybe pmac_zilog doesnt play well together with the 8250, or it doesnt
> initalize everything correctly.

Sure, pmac_zilog doesn't play well with 8250, but shouldn't cause such
a crash. What machine is it btw ? Can you send me a fix for pmac_feature
not detecting the model properly ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
