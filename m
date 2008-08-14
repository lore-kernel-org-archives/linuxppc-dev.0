Return-Path: <sinisa.denic@abs-cs.com>
Received: from abs-beograd.co.yu (mail.abs-beograd.co.yu [80.93.243.15])
	by ozlabs.org (Postfix) with ESMTP id 223FEDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 19:55:51 +1000 (EST)
Received: from WorldClient by abs-beograd.co.yu (MDaemon PRO v9.6.6)
	with ESMTP id md50000141900.msg
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 11:52:20 +0200
Date: Thu, 14 Aug 2008 11:52:17 +0200
From: "Sinisa Denic" <sinisa.denic@abs-cs.com>
To: <linuxppc-dev@ozlabs.org>
Subject: mpc52xx localplus bus and dm9000
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <WorldClient-F200808141152.AA52170076@abs-cs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,I have mpc52xx based board very similar to lite5200b.
There is Davicom DM9000 connected to Local Plus Bus CS0.
Does anybody have idea how should DTS part look like in order to add this 
resource in system.
I've written something like this:

lpb {
                        device_type = "network";
                        compatible = "fsl,lpb";
                        ranges = <0 0 ff000000 1000000>;

                        dm9000@0,0 {
                                compatible = "dm9000";
                                reg = <0 0 100000>;
                                #size-cells = <1>;
                                #address-cells = <1>;
                        };
                };

but it's not working.
Is it enough to have right dts record for default dm9000 driver working
or I have to change something more?
Thank you in andvance.

Sinisa Denic
System and software  engineer
tel: +381(0)112016142
ABS Control Systems
bul.Zorana Djindjica 8a
Belgrade,Serbia
