Date: Thu, 11 Apr 2002 20:31:25 -0700
From: Matt Porter <mporter@mvista.com>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: meaning of error
Message-ID: <20020411203125.A5308@home.com>
References: <D73A25AA6E54D511AD74009027B1110F0F315D@ORION>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F0F315D@ORION>; from BlakesleeS@embeddedplanet.com on Thu, Apr 11, 2002 at 05:23:56PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 05:23:56PM -0400, Steven Blakeslee wrote:
>
> Any help would be appreciated.  In the error "Kernel panic: VFS: Unable to
> mount root fs on 01:01" what does the 01:01 stand for?  I've also seen 00:00
> and 01:00.

Major:Minor of the root device it attempted and failed to open.

See Documentation/devices.txt in your kernel source for information
on the assignment of these values.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
