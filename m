Return-Path: <avorontsov@ru.mvista.com>
Date: Tue, 31 Mar 2009 23:05:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 1/4] NAND: FSL-UPM: add multi chip support
Message-ID: <20090331190517.GA23767@oksana.dev.rtsoft.ru>
References: <20090330100241.346785618@denx.de>
	<20090330100554.947307803@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090330100554.947307803@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 12:02:42PM +0200, Wolfgang Grandegger wrote:
> This patch adds support for multi-chip NAND devices to the FSL-UPM
> driver. This requires support for multiple GPIOs for the RNB pins.
> The NAND chips are selected through address lines defined by the
> FDT property "fsl,upm-addr-line-cs-offsets".
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
