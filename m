Date: Sun, 18 Feb 2001 09:28:28 -0700
From: Matt Porter <mmporter@home.com>
To: Subodh Nijsure <SNijsure@SkyStream.com>
Cc: "'Dan Malek'" <dan@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How does one get physical address for iorempped window?
Message-ID: <20010218092828.A14685@cx258813-a.chnd1.az.home.com>
References: <B25E2E5A003CD311B61E00902778AF2A0148B711@SERVER1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A0148B711@SERVER1>; from SNijsure@SkyStream.com on Thu, Feb 15, 2001 at 09:58:59AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 15, 2001 at 09:58:59AM -0800, Subodh Nijsure wrote:
>
> I know the physical address I should be writing to.
>
> For debugging I was trying to print exact physical address where
> write is happening .When I used virt_to_phys() on the addresse
> ioremap() I was not getting back the original physical address.
> Hence the question.

Well, the base problem is that virt_to_*/*_to_virt were only ever
intended to work on addresses mapped to system RAM.  See
Documentation/IO-mapping.txt.  Why not just store argument one to
ioremap to calculate the physical addresses you are working with
in virtual space?

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
