Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C0F9DB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 00:41:06 +1000 (EST)
Message-ID: <4E42987F.9040304@grandegger.com>
Date: Wed, 10 Aug 2011 16:41:03 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v10 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
References: <1312945564-6626-1-git-send-email-holt@sgi.com>	<1312945564-6626-6-git-send-email-holt@sgi.com>	<4E428BFF.7060402@grandegger.com>
	<20110810141550.GQ4926@sgi.com>
In-Reply-To: <20110810141550.GQ4926@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2011 04:15 PM, Robin Holt wrote:
> On Wed, Aug 10, 2011 at 03:47:43PM +0200, Wolfgang Grandegger wrote:
...
> Done, except the
>>           compatible = "fsl,p1010-flexcan", "fsl,flexcan";
> 
> line is
> 	compatible = "fsl,flexcan", "fsl,flexcan-p1010";

IIRC, there order is more to less specific, e.g. for I2C:

  compatible = "fsl,mpc5200-i2c", "fsl-i2c"

...

>> Please also correct the node names (not using the number suffix).
> 
> So the node names should be
> 		can@1c000 {
> 		can@1d000 {
> correct?

Yes, just have a look how other node names are constructed, e.g. for
sata, serial, rtc, etc.:

  $ grep serial@ *.dts
  ...
  pdm360ng.dts:		serial@11000 {
  pdm360ng.dts:		serial@11100 {
  pdm360ng.dts:		serial@11200 {
  pdm360ng.dts:		serial@11300 {
  pdm360ng.dts:		serial@11400 {
  pdm360ng.dts:		serial@11600 {
  pdm360ng.dts:		serial@11800 {
  pdm360ng.dts:		serial@11B00 {
  ...

Wolfgang.
