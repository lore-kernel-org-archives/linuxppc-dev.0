Date: Thu, 11 Oct 2001 09:32:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: PAULO SELEME CORREA PAULO <paulo.correa@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: hard hat kernel problems when booting with a rpx classic board
Message-ID: <20011011093231.J12016@cpe-24-221-152-185.az.sprintbbd.net>
References: <sbc5507b.064@siemens.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <sbc5507b.064@siemens.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 11, 2001 at 07:55:12AM -0300, PAULO SELEME CORREA PAULO wrote:

> I've got the follwing problem when trying to boot a rpx classic(ppc860) board with the Hard Hat 2.0,
> Oops: kernel access of bad area, sig: 11. Does anyone know what is happenning?
>  I am showing the Terminal messages below.
> Any help will be wellcome!

It looks very much like your 860 needs the CPU6 errata workaround
enabled.  You should have the source for the lsp around in
/opt/hardhat/devkit/lsp/embeddedplanet-cllf/

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
