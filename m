Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.192])
	by ozlabs.org (Postfix) with ESMTP id 8A19267FE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 01:07:43 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so152893wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 08:07:42 -0700 (PDT)
Message-ID: <528646bc0508100807a3a0a8a@mail.gmail.com>
Date: Wed, 10 Aug 2005 09:07:42 -0600
From: Grant Likely <glikely@gmail.com>
To: Joel Isaacson <joel@ascender.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <42F8C436.7010706@ascender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <42F8C436.7010706@ascender.com>
Subject: Re: mpc5200 linux source
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/9/05, Joel Isaacson <joel@ascender.com> wrote:
> Hi
>=20
> My name is Joel Isaacson. I'm a consultant working on a Linux mpc5200
> embedded card. We are working with the 2.4 Denx linux kernel. I saw from
> a mailing that you are  using the 2.6  kernel with SIP support that you
> added. What is the status of the 2.6 port? The latest kernel doesn't
> seem to have the Ethernet (fec, bestcomm) support.
>=20
Here's a post from Sylvain pointing to his mpc5200 git tree.  The
Ethernet driver has not yet been rolled into mainline because the
BestComm DMA engine does not yet conform to the platform bus.  You
must get the driver from Sylvain's tree if you want to use Ethernet.

http://ozlabs.org/pipermail/linuxppc-embedded/2005-June/018887.html

Do you mean SIP or SPI?  I wrote a simple SPI subsystem for my own use
which is posted to the linuxppc-embedded mailing list.  Unlike most
SPI subsystems out there, it is NOT based on the I2C subsystem.  There
are a number of good SPI subsystem implementations out there that you
can choose from.

BTW, you can subscribe to the linuxppc-embedded mailing list from here:

https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Cheers,
g.
