From: tom_gall@mac.com
Date: Fri, 2 Apr 2004 16:41:04 -0600
Subject: Re: How did the 2.6 kernel headers get so screwed up?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
In-Reply-To: <3AB702B8-84D1-11D8-9FF0-000A95A07384@sands-edge.com>
Message-Id: <D3494712-84F6-11D8-8FE5-0003939E069A@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've seen the same. Just trying building mac-fdisk against the 2.6
kernel headers. Absolutely an uphill battle.

Even glibc wasn't building (ppc64) for a bit there against some
versions of the 2.6 kernel headers.

Fun fun fun. NOT!

Regards,

Tom

On Friday, April 2, 2004, at 12:11 PM, John Whitney wrote:
>
> The title says it all.
>
> I have a program I wrote to interface with the i2c bus. It includes
> <linux/i2c.h> in order to get the I2C_SLAVE ioctl value, necessary to
> set the slave address.
>
> In 2.4 this works beautifully. Now, in 2.6, I get boatloads of errors:
> redefinitions, admonishments not to use kernel headers from user
> programs, missing constants, you name it.
>
> And this has happened to me in more than one standard unix application
> (strace, syslogd, etc.).
<snip>

Tom Gall
gentoo-ppc64 lead -- God started with stage 1, shouldn't you?
tgall aatt gentoo.org
tgall aatt uberh4x0r.org
tom_gall aatt mac.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
