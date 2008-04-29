Return-Path: <ndroogh@rogers.com>
Received: from smtp109.rog.mail.re2.yahoo.com (smtp109.rog.mail.re2.yahoo.com
	[68.142.225.207]) by ozlabs.org (Postfix) with SMTP id AF9CEDED79
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 06:29:24 +1000 (EST)
Message-ID: <48178394.2060704@rogers.com>
Date: Tue, 29 Apr 2008 16:22:44 -0400
From: Nick <ndroogh@rogers.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: MPC5200b problem configuring PSC6 as a serial port
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: ndroogh@rogers.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Everyone,

Has anyone setup and used the MPC5200b PSC6 port as a serial port?  I am 
having trouble getting mine to work.  I am using PSC1, 2 and 3 already, 
and they work fine.  In my DTS file,  I have PSC6 configured like this:

serial@2c00 {  // PSC6
    device_type = "serial";
    compatible = "mpc5200b-psc-uart","mpc5200-psc-uart";
    port-number = <5>;
    reg = <2c00 100>;
    interrupts = <2 4 0>.;
    interrupt-parent = <&mpc5200_pic>;
};

Is there anything special I need to do to get this port working?

Thanks,

Nick
