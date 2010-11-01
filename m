Return-Path: <timur.tabi@gmail.com>
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20101101051734.GB17587@angua.secretlab.ca>
References: <1288130833-16421-1-git-send-email-ddaney@caviumnetworks.com>
	<20101101051734.GB17587@angua.secretlab.ca>
From: Timur Tabi <timur@freescale.com>
Date: Mon, 1 Nov 2010 07:04:17 -0500
Message-ID: <AANLkTinTuizm6pij_GWkCqDDH0qRFS6j5ZRzTUJFF_7O@mail.gmail.com>
Subject: Re: [PATCH] OF device tree: Move of_get_mac_address() to a common
	source file.
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 1, 2010 at 12:17 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:

>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Wolfram Sang <w.sang@pengutronix.de>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Corey Minyard <cminyard@mvista.com>
>> Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
>> Cc: Vitaly Bordug <vbordug@ru.mvista.com>
>> Cc: Anatolij Gustschin <agust@denx.de>
>> Cc: John Rigby <jcrigby@gmail.com>
>> Cc: Wolfgang Denk <wd@denx.de>
>> Cc: Anton Vorontsov <avorontsov@mvista.com>
>> Cc: Sandeep Gopalpet <Sandeep.Kumar@freescale.com>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: Li Yang <leoli@freescale.com>
>> Cc: Sergey Matyukevich <geomatsi@gmail.com>
>> Cc: Jiri Pirko <jpirko@redhat.com>
>> Cc: Eric Dumazet <eric.dumazet@gmail.com>
>> Cc: Sean MacLennan <smaclennan@pikatech.com>
>> Cc: Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>
>> Cc: Andres Salomon <dilinger@queued.net>
>> Cc: microblaze-uclinux@itee.uq.edu.au
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: netdev@vger.kernel.org
>> Cc: devicetree-discuss@lists.ozlabs.org
>
> You don't need to believe everything that get_maintainers is telling
> you. =A0When you get a large list like this, don't Cc everyone, but
> apply some educated guesses. =A0You can guess that the PowerPC and
> Microblaze maintainers care because it touches their trees, and you
> can guess that I care because I'm the dt maintainer. David Miller
> isn't a bad guess because of networking. =A0But 22 people is excessive.

And ironically, he left out the person who wrote the function -- me.

--=20
Timur Tabi
Linux kernel developer at Freescale
