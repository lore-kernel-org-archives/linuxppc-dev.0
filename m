Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: issues calling of_platform_bus_probe() twice
Date: Sun, 18 Mar 2012 16:14:23 +0000
Message-ID: <4F6609DE.2050001@freescale.com>
References: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
 <1331933034.3105.171.camel@pasglop> <20120317072717.738953E08CE@localhost>
 <4F649304.9010001@freescale.com> <20120318090804.C70493E060A@localhost>
In-Reply-To: <20120318090804.C70493E060A@localhost>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>,
 "devicetree-discuss@lists.ozlabs.org
 Discuss" <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> That's because you're using it wrong.  of_platform_bus_probe() creates
> platform devices at the starting level and every level below it as
> described by the bus ids.  It is illegal to call of_platform_bus_probe()
> twice at the same level in the DT.

Well, *I* am not using it wrong.  Notice that my patch fixes (or works=20
around) the commit that *did* do it wrong:

http://patchwork.ozlabs.org/patch/126289/

--=20
Timur Tabi
Linux kernel developer at Freescale=
