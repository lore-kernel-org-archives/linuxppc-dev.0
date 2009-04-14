Return-Path: <gerickson@nuovations.com>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
	by ozlabs.org (Postfix) with SMTP id 1EE46DDF74
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 00:11:40 +1000 (EST)
Date: Tue, 14 Apr 2009 07:04:51 -0700
Subject: Re: Help!Some memory doesn't work on PPC405Ex based board!
From: Grant Erickson <gerickson@nuovations.com>
To: SunNeo <sunwx2001@hotmail.com>
Message-ID: <C609E613.15D18%gerickson@nuovations.com>
In-Reply-To: <BAY114-W4176A96E45AE37FB5FBE02AB7C0@phx.gbl>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/14/09 4:08 AM, SunNeo wrote:
> My platform uses the MICRON MT47H256M8THN DDRII SDRAM and the DDRII SDRAM is
> soldered on the board.
> 
> As I said, my board was similar with "Kilauea" evb, so I created my
> configuration header file from Kilauea's at U-Boot. In the configuration file,
> register value for the DDR SDRAM controller is defined. But I have removed DDR
> autocalibraton related configuration from the configuration file, do you think
> this will cause any issues?

Sun:

Does your board have ECC? While it seems like simply following the static,
non-auto-calibrating configuration of the Kilauea or Haleakala board would
be sufficient, my experience is that it is not, especially if your design
has ECC.

Should you decide to escalate the issue with AMCC, I suspect
auto-calibration will be the first thing they ask you to enable and re-check
your design with.

Per Stefan's comments, unless you use an intensive and comprehensive memory
test of some sort, just running u-boot is not necessarily a sufficient
validation that memory works as it, in many configurations, touches and uses
little of the overall RAM during its operation.

Regards,

Grant
