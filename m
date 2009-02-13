Return-Path: <vijay.t.nikam@gmail.com>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.156])
	by ozlabs.org (Postfix) with ESMTP id EE4F6DDF7A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 21:37:01 +1100 (EST)
Received: by po-out-1718.google.com with SMTP id b23so3023010poe.4
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 02:37:00 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 13 Feb 2009 16:07:00 +0530
Message-ID: <f234e2140902130237s36c21c2fga5a2e9ab8d24dcd2@mail.gmail.com>
Subject: Not able to see any output if kernel module loaded for the first time
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

I am facing perhaps some strange kind of problem. I have mpc8313erdb
eval board and wrote the GPIO driver, the driver is just making the
assigned GPIO[3] pin high and low.

If I load this module first time after bootup or if I make some change
in the code and compile and load the module, then I am not able to see
any output on the scope but if I load it again then I will be able to
see the output on the scopt that GPIO[3] pin has became high and low.
Later if I removed the kernel module and load it again then also I am
able to see the output on the scope, till I do the reboot or power-off
and on.

Could anyone let me know why this happening ... thanks ...

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam
