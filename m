Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 7D59E67A7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 18:37:18 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 10 Mar 2005 08:37:08 +0100
References: <0007F077BB3476449151699150E8FEA205928C@exchange.tsi-telsys.com>
In-Reply-To: <0007F077BB3476449151699150E8FEA205928C@exchange.tsi-telsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503100837.08717.g.jaeger@sysgo.com>
Cc: Sanjay Bajaj <sbajaj@tsi-telsys.com>
Subject: Re: PPC 440GX with NS DP83865 phy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 09 March 2005 18:11, Sanjay Bajaj wrote:
> Has anybody used PPC 440GX with NS DP83865 phy? If you have or have any
> information to set it up, please share. 
> 
We're using this PHY on a custom 440GX board. Connected via GMII!
After setting up the RGMII bridge correctly (see manual), you also have to
tweak the EMAC driver. I have sent a patch (which has been rejected) a few
weeks ago to the list which changes the setup procedure of the EMAC to work
with a DP83865 PHY. THe current implementation will not work.

Regards
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
