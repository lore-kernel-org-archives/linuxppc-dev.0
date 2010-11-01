Return-Path: <timur.tabi@gmail.com>
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20101101051734.GB17587@angua.secretlab.ca>
References: <1288130833-16421-1-git-send-email-ddaney@caviumnetworks.com>
	<20101101051734.GB17587@angua.secretlab.ca>
From: Timur Tabi <timur@freescale.com>
Date: Mon, 1 Nov 2010 10:46:03 -0500
Message-ID: <AANLkTimp-AFN5T3z9o6X9qM-GQXSU5vinf+Lqu_jUmJj@mail.gmail.com>
Subject: Re: [PATCH] OF device tree: Move of_get_mac_address() to a common
	source file.
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 1, 2010 at 12:17 AM, Grant Likely <grant.likely@secretlab.ca> wrote:

> Applied, thanks; but made some changes to protect this code because it
> does not work on little endian (it can be fixed in a separate patch)

I'm confused.  How does of_get_mac_address() not work on little-endian?

-- 
Timur Tabi
Linux kernel developer at Freescale
