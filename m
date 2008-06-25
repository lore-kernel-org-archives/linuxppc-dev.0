Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <486299AF.8080909@am.sony.com>
Date: Wed, 25 Jun 2008 12:17:03 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stefan Wald <WALD@de.ibm.com>
Subject: Re: [Cbe-oss-dev] 2.6.26-rc6 kernel bug on PS3?
References: <OFD9B4725E.630B28FC-ONC1257473.00470E7C-C1257473.00479305@de.ibm.com>
In-Reply-To: <OFD9B4725E.630B28FC-ONC1257473.00470E7C-C1257473.00479305@de.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 06/25/2008 06:01 AM, Stefan Wald wrote:
> Hi,
> I think we have a kernel bug here... running a multimedia app with about 20
> spe contexts.
> Application hangs after a while defunct and dmesg output looks like d.txt.

Is it repeatable?

Nothing in your dump looks ps3 specific.  Did you try with a Cell Blade?

Could you try with an older kernel?

-Geoff
