Date: Tue, 30 Sep 2003 13:47:16 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	lm78@Stimpy.netroedge.com
Subject: Re: MPC10x I2C driver update
Message-ID: <20030930204716.GA20450@kroah.com>
References: <1064915037.12438.1142.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1064915037.12438.1142.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 30, 2003 at 10:43:55AM +0100, Adrian Cox wrote:
> I have released a small update to my driver for the
> MPC107/MPC8240/MPC8245 I2C adapter. This corrects a bug reported by
> several people: the transfer function now follows the other I2C
> algorithm drivers by returning the number of elements transferred.
>
> http://www.humboldt.co.uk/mpc10xi2c.html
>
> I'd like to get this into the kernel. Which would be more useful to
> people:
> 1) Getting it into lm-sensors?
> 2) Getting it into linuxppc-2.4-devel?

3) sending me a patch to get it into the 2.6 kernel tree.

:)

thanks,

greg k-h

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
