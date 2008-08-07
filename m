Return-Path: <timur@freescale.com>
Message-ID: <489B3AE5.109@freescale.com>
Date: Thu, 07 Aug 2008 13:11:49 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Yoder Stuart <stuart.yoder@freescale.com>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca><20080806060239.30717.79273.stgit@trillian.secretlab.ca><ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
	<20080807061254.GB12571@yookeroo.seuss>
	<9696D7A991D0824DBA8DFAC74A9C5FA3043BC7D7@az33exm25.fsl.freescale.net>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3043BC7D7@az33exm25.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org, paulus@samba.org,
	miltonm@bga.com, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yoder Stuart wrote:

> The second was the idea that we may need a /aliases/stdin as well.
> You could conceptually have stdout be a monitor and a stdin
> be a keyboard.

I don't think the hypervisor console subsystem supports this.  I don't see any
way of registering separate clients for input vs. output.

-- 
Timur Tabi
Linux kernel developer at Freescale
